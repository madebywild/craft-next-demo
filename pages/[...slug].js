import React from "react";
import dynamic from "next/dynamic";
import {fetchData} from "../cms/api";
import {
  PAGE_SLUGS_QUERY,
  PAGE_DATA_QUERY,
  JOURNAL_DATA_QUERY,
  GLOBAL_SITE_SETTINGS_QUERY,
} from "../cms/queries";

const BlockMap = {
  pageBlocks_copy_BlockType: dynamic(() => import("../components/CopyBlock/CopyBlock")),
  pageBlocks_media_BlockType: dynamic(() => import("../components/MediaBlock/MediaBlock")),
  journalMainMedia_media_BlockType: dynamic(() => import("../components/JournalMainMedia/JournalMainMedia")),
};

const Page = ({ pageData, siteSettings }) => (
  <main>
    {console.log(pageData.journalMainMedia)}
    {/* {pageData.journalMainMedia && <BlockMap.journalMainMedia_media_BlockType {...pageData.journalMainMedia} />} */}
    {pageData.pageBlocks.map((block) => {
      if (BlockMap[block.blockType] === undefined) {
        return (
          <section>
            The section {block.blockType} is not yet defined in the GraphQL Query
          </section>
        );
      }

      const BlockComponent = BlockMap[block.blockType];

      return (
        <section key={block.uid} id={block.uid}>
          <BlockComponent {...block} />
        </section>
      );
    })}
  </main>
);

/**
 * Fetch page data for current slug.
 */
export const getStaticProps = async({ params = {} }) => {

  const siteSettings = await fetchData(
    GLOBAL_SITE_SETTINGS_QUERY
  );

  let pageData;

  let query;
  if (params.slug && Array.isArray(params.slug) && params.slug[0] === "journal") {
    query = JOURNAL_DATA_QUERY;
  } else {
    query = PAGE_DATA_QUERY;
  }
  if (!params || Object.keys(params).length === 0 && params.constructor === Object) {
    pageData = await fetchData(query, {
      uri: "index",
    });
    // Top level page.
  } else if (params.slug && typeof params.slug === "string") {
    pageData = await fetchData(query, {
      uri: params.slug,
    });
    // Nested page.
  } else if (params.slug && Array.isArray(params.slug)) {
    pageData = await fetchData(query, {
      uri: params.slug.join("/"),
    });
  } else {
    pageData = {};
  }

  // console.log("pageData", pageData.entry);

  return {
    props: {
      pageData: pageData.entry,
      siteSettings,
    },
    unstable_revalidate: 1,
  };
};

/**
 * Fetch all available pageBlocks slugs.
 */
export const getStaticPaths = async() => {
  const result = await fetchData(PAGE_SLUGS_QUERY);
  // Home page. The `index.js` imports this file directly and therefore `params` is undefined.
  // FIXME: https://github.com/zeit/next.js/issues/9081
  const paths = result.entries
    .filter((p) => !!p?.slug && p.slug !== "index")
    .map((p) => `/${p.slug}`);
  return {
    paths,
    fallback: false,
  };
};

export default Page;
