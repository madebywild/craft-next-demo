import React from "react";
import styled from "styled-components";

const Container = styled.div`
  p {
    background-color: #ccc;
    padding: 1rem;
  }

  h1 {
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 1rem;
  }
`;

const CopyBlock = (props) => (
  <>
    <Container>
      <div dangerouslySetInnerHTML={{ __html: props.baseCopy }} />
    </Container>
  </>
);

export default CopyBlock;
