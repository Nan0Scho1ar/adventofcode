{-# LANGUAGE OverloadedStrings #-}

-- ExtractDayDesc.hs
-- Keeps only the inner content of <article class="day-desc"> ... </article>
-- Also removes header identifiers so you don't get {#id} in Markdown output.

import Text.Pandoc.JSON
import Text.Pandoc.Definition
import Text.Pandoc.Walk (walk)

main :: IO ()
main = toJSONFilter removeHeaderIds

-- Remove all header identifiers
removeHeaderIds :: Pandoc -> Pandoc
removeHeaderIds = walk clearHeaderId
  where
    clearHeaderId (Header level (_, classes, kvs) inlines) =
      Header level ("", classes, kvs) inlines
    clearHeaderId x = x

-- -- | Keep only top-level Divs likely from <article>, unwrap them,
-- --   and remove header IDs
-- extractDayDesc :: Pandoc -> Pandoc
-- extractDayDesc (Pandoc meta blocks) =
--     let articleBlocks = concatMap unwrapArticleDiv blocks
--         cleanedBlocks = walk clearHeaderId articleBlocks
--     in Pandoc meta cleanedBlocks

-- -- | If it's an article Div, return its contents; otherwise discard
-- unwrapArticleDiv :: Block -> [Block]
-- unwrapArticleDiv (Div (_id, classes, attrs) content)
--     | "day-desc" `elem` classes || ("role","main") `elem` attrs = content
-- unwrapArticleDiv _ = []

-- -- Helper for walking headers inside blocks
-- clearHeaderId :: Block -> Block
-- clearHeaderId (Header level (_, classes, kvs) inlines) =
--     Header level ("", classes, kvs) inlines
-- clearHeaderId x = x
