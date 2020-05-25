import React from "react";
import * as T from "../types";

const TextBlock: React.FC<T.TextBlock> = ({ headline, content }) => (
  <article>
    <h1>{headline}</h1>
    <p>{content}</p>
  </article>
);

export default TextBlock;
