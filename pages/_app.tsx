import React from "react";
import { NextPage } from "next";
import { AppProps } from "next/app";

import "destyle.css/destyle.css";

const App: NextPage<AppProps> = ({ Component, pageProps }) => {
  return <Component {...pageProps} />;
};

export default App;
