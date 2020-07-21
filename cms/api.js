import { request } from "graphql-request";
import { print } from "graphql/language/printer";

export const fetchData = async(
  query,
  vars
) => {
  const queryString = typeof query === "string" ? query : print(query);

  try {
    const data = await request(process.env.CRAFT_API_ENDPOINT, queryString, vars);
    return data;
  } catch (e) {
    console.error(e);
    return {};
  }
};
