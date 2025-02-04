import { useQuery, gql } from "@apollo/client";
import Section from "../components/Section";

const GET_MENU = gql`
  query GetMenu {
    menus {
      id
      label
      menuSections {
        displayOrder
        section {
          id
          label
          description
          isAvailable
          sectionItems {
            displayOrder
            item {
              id
              label
              price
              description
              availableQuantity
              imageUrl
            }
          }
        }
      }
    }
  }
`;


const MenuPage = ({ 
  sectionRefs
}: {
  sectionRefs: React.MutableRefObject<Record<string, HTMLElement | null>>,
  setActiveSection: (id: number) => void
}) => {
  const { loading, error, data } = useQuery(GET_MENU);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error.message}</p>;

  const menusWithSortedSections = data.menus.map((menu: any) => ({
    ...menu,
    menuSections: [...menu.menuSections].sort((a: any, b: any) => a.displayOrder - b.displayOrder)
  }));  

  return (
    <div className="flex">
      <div className="p-6 flex-1">
        {menusWithSortedSections.map((menu: any) => (
            <div key={menu.id}>
              <h1 className="text-3xl font-bold mb-4">{menu.label}</h1>
              {menu.menuSections
                .map((menuSection: any) => {
                  const section = menuSection.section;
                  return (
                    <Section 
                      id={section.id} 
                      class="section" 
                      key={section.id} 
                      {...section} 
                      ref={(el: any) => (sectionRefs.current[section.id] = el)} 
                    />
                  );
                })}
            </div>
          ))}
      </div>
    </div>
  );
};

export default MenuPage;
