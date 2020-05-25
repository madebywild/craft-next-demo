import React from "react";
import dynamic from "next/dynamic";
import { NextPage, GetStaticPaths, GetStaticProps } from "next";
import * as T from "../types";

const BlockMap = {
  [T.BlockType.Text]: dynamic(() => import("../components/TextBlock")),
} as const;

const Page: NextPage<T.PageData> = ({ pageBlocks = [] }) => (
  <main>
    {pageBlocks.map((block) => {
      const BlockComponent = BlockMap[block.__typename];

      return (
        <section key={block.__uid} id={block.__uid}>
          <BlockComponent {...block} />
        </section>
      );
    })}
  </main>
);

/**
 * Fetch page data for current slug.
 */
export const getStaticProps: GetStaticProps<T.PageData> = async ({ params = {} }) => {
  const request = await fetch(process.env.CRAFT_API_ENDPOINT!, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      query: `
      {
        entry(section: "page", slug: "${params.slug}") {
          ... on page_page_Entry {
            title,
            pageBlocks {
              ... on pageBlocks_textBlock_BlockType {
                __typename
                __uid: uid
                headline: textBlockHeadline
                content: textBlockContent
              }
            }
          }
        }
      }
    `,
    }),
  });

  const { data: result } = await request.json();

  return {
    props: result.entry || {},
    unstable_revalidate: 1,
  };
};

/**
 * Fetch all available page slugs.
 */
export const getStaticPaths: GetStaticPaths = async () => {
  const request = await fetch(process.env.CRAFT_API_ENDPOINT!, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      query: `
      {
        entries(section: "page") {
          ... on page_page_Entry {
            slug
          }
        }
      }
    `,
    }),
  });

  const { data: result } = await request.json();
  const paths = result.entries.map((p: any) => `/${p.slug}`);

  return {
    paths,
    fallback: false,
  };
};

export default Page;
