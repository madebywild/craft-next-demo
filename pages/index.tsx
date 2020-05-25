import React from "react";
import Head from "next/head";

export default function Home() {
  return (
    <>
      <Head>
        <title>Create Next App</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main>main</main>
      <footer>footer</footer>

      <style jsx>{`
        .container {
          min-height: 100vh;
          display: flex;
          flex-direction: column;
          justify-content: center;
        }

        main {
          flex: 1;
        }

        footer {
          border-top: 1px solid #eaeaea;
        }
      `}</style>
    </>
  );
}
