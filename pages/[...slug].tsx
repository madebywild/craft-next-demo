import React from "react";
import dynamic from "next/dynamic";
import { NextPage, GetStaticPaths, GetStaticProps } from "next";
import * as T from "../types";

const BlockMap = {
  [T.BlockType.Text]: dynamic(() => import("../components/TextBlock")),
} as const;

const Page: NextPage<T.PageData> = ({ blocks = [] }) => (
  <main>
    {blocks.map((block) => {
      const BlockComponent = BlockMap[block.__typename];

      return (
        <section key={block.__uid} id={block.__uid}>
          <BlockComponent {...block} />
        </section>
      );
    })}
  </main>
);

export const getStaticProps: GetStaticProps<T.PageData> = async ({ params = {} }) => {
  console.log(process.env.API_ENDPOINT, params.slug);
  const props = await new Promise<T.PageData>((r) => r({ blocks: [] }));

  return {
    props,
    unstable_revalidate: 1,
  };
};

export const getStaticPaths: GetStaticPaths = async () => {
  const paths = await new Promise<string[]>((r) => r(["/index"]));

  return {
    paths,
    fallback: false,
  };
};

export default Page;
