export enum BlockType {
  "Text" = "TextBlock",
}

export interface BaseBlock {
  __typename: BlockType;
  __uid: string;
}

export interface TextBlock extends BaseBlock {
  __typename: BlockType.Text;
  headline: string;
  content: string;
}

export interface PageData {
  blocks: TextBlock[];
}
