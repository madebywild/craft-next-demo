import React from "react";
import Head from "next/head";

const Home: React.FC = () => {
  return (
    <>
      <Head>
        <title>craftnext-frontend</title>
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
};

export default Home;
