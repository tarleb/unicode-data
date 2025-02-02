-- |
-- Module      : Unicode.Char.Case.Compat
-- Copyright   : (c) 2020 Composewell Technologies and Contributors
-- License     : Apache-2.0
-- Maintainer  : streamly@composewell.com
-- Stability   : experimental
--
-- Compatibility module for case and case mapping related functions..
--
-- The functions of this module are drop-in replacement for those in "Data.Char".
-- They are similar but not identical to some functions in "Unicode.Char.Case",
-- therefore they are placed in a separate module in order to avoid ambiguity.
--
module Unicode.Char.Case.Compat
    ( -- * Predicates
      isUpper
    , isLower
      -- * Case conversion
    , toUpper
    , toLower
    , toTitle
    ) where

import Unicode.Char.General (GeneralCategory(..), generalCategory)
import qualified Unicode.Internal.Char.UnicodeData.SimpleLowerCaseMapping as C
import qualified Unicode.Internal.Char.UnicodeData.SimpleTitleCaseMapping as C
import qualified Unicode.Internal.Char.UnicodeData.SimpleUpperCaseMapping as C

-- | Selects upper-case or title-case alphabetic Unicode characters (letters).
-- Title case is used by a small number of letter ligatures like the
-- single-character form of /Lj/.
--
-- prop> isUpper c == Data.Char.isUpper c
--
-- @since 0.3.0
isUpper :: Char -> Bool
isUpper c = case generalCategory c of
    UppercaseLetter -> True
    TitlecaseLetter -> True
    _               -> False

-- | Selects lower-case alphabetic Unicode characters (letters).
--
-- prop> isLower c == Data.Char.isLower c
--
-- @since 0.3.0
isLower :: Char -> Bool
isLower c = case generalCategory c of
    LowercaseLetter -> True
    _               -> False

-- | Convert a letter to the corresponding upper-case letter, if any.
-- Any other character is returned unchanged.
--
-- prop> toUpper c == Data.Char.toUpper c
--
-- @since 0.3.0
{-# INLINE toUpper #-}
toUpper :: Char -> Char
toUpper = C.toSimpleUpperCase

-- | Convert a letter to the corresponding lower-case letter, if any.
-- Any other character is returned unchanged.
--
-- prop> toLower c == Data.Char.toLower c
--
-- @since 0.3.0
{-# INLINE toLower #-}
toLower :: Char -> Char
toLower = C.toSimpleLowerCase

-- | Convert a letter to the corresponding title-case or upper-case letter,
-- if any. (Title case differs from upper case only for a small number of
-- ligature letters.) Any other character is returned unchanged.
--
-- prop> toTitle c == Data.Char.toTitle c
--
-- @since 0.3.0
{-# INLINE toTitle #-}
toTitle :: Char -> Char
toTitle = C.toSimpleTitleCase