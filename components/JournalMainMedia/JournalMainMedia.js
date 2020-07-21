import React from "react";
import styled from "styled-components";

const Container = styled.div`
  img {
    max-width: 100%;
    height: auto;
  }
`;

const JournalMainMedia = (props) => (
  <>
    <Container>
      {props.baseVideo[0] !== null && props.baseVideo[0] !== undefined &&
        <video
          src={props.baseVideo[0].url}
          poster={`${props.baseImage[0].url}?w=1920`}
          autoPlay
          muted
          playsInline
        >
        </video>
      }

      {props.baseVideo[0] === null || props.baseVideo[0] === undefined &&
        <img src={props.baseImage[0].url} alt="alt" />
      }
    </Container>
  </>
);

export default JournalMainMedia;
