import React from "react";
import * as T from "../types";

const TextBlock: React.FC<T.TextBlock> = ({ headline, content }) => (
  <>
    <article>
      <h1>{headline}</h1>
      <div dangerouslySetInnerHTML={{ __html: content }} />
    </article>

    <style jsx>{`
      article {
        background-color: #ccc;
        padding: 1rem;
      }

      h1 {
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 1rem;
      }
    `}</style>
  </>
);

export default TextBlock;
