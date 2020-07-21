import gql from "graphql-tag";

import CopyBlockFragment from "../components/CopyBlock/Fragment";
import MediaBlockFragment from "../components/MediaBlock/Fragment";
import JournalMainMediaFragment from "../components/JournalMainMedia/Fragment";

export const PAGE_SLUGS_QUERY = gql`
  query PageSlugs {
    entries {
      slug: uri
    }
  }
`;

export const GLOBAL_SITE_SETTINGS_QUERY = gql`
  query SiteSettings {
    globalSets {
      ... on globals_GlobalSet {
        siteNavPrimary {
          ... on siteNavPrimary_navItem_BlockType {
            navLink {
              text: customText
              url
            }
          }
        }
      }
    }
  }
`;


export const PAGE_DATA_QUERY = gql`
  query PageData($uri: [String]) {
    entry(uri: $uri) {
      title
      sectionHandle
      ... on pages_pages_Entry {
        pageBlocks {
          blockType: __typename
          ... ${CopyBlockFragment}
          ... ${MediaBlockFragment}
        }
      }
    }
  }
`;

export const JOURNAL_DATA_QUERY = gql`
  query JournalData($uri: [String]) {
    entry(uri: $uri) {
      title
      sectionHandle
      author {
        fullName
      }
      postDate
      ... on journal_journal_Entry {
        journalMainMedia {
          ... ${JournalMainMediaFragment}
        }
        pageBlocks {
          blockType: __typename
          ... ${CopyBlockFragment}
          ... ${MediaBlockFragment}
        }
      }
    }
  }
`;
