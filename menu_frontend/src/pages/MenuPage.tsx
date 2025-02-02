import { useQuery, gql } from "@apollo/client";
// import MenuSection from "../components/MenuSection";

const GET_MENU = gql`
  query GetMenu {
    menus {
      id
      label
      sections {
        id
        label
        items {
          id
          label
          price
          description
        }
      }
    }
  }
`;

const MenuPage = () => {
  const { loading, error, data } = useQuery(GET_MENU);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error.message}</p>;

  return (
    <div>
      {data.menus.map((menu: any) => (
        <div key={menu.id}>
          <h2>{menu.label}</h2>
          {menu.sections.map((section: any) => (
            `hello this is the ${section.label} section`
            // <MenuSection key={section.id} section={section} />
          ))}
        </div>
      ))}
    </div>
  );
};

export default MenuPage;
