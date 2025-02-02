// import React from "react";
import { useQuery, gql } from "@apollo/client";

// const categories = [
//   { id: "kueh-cakes", name: "Kuehs & Cakes" },
//   { id: "kaya", name: "Kaya" },
//   { id: "gift-bundles", name: "Gift Boxes & Bundles" },
// ];

const GET_SECTIONS = gql`
  query GetSections {
    sections {
      label
    }
  }
`;

const Sidebar = () => {
  const { loading, error, data } = useQuery(GET_SECTIONS);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error.message}</p>;

  const handleScroll = (id: string) => {
    document.getElementById(id)?.scrollIntoView({ behavior: "smooth" });
  };

  return (
    <aside className="sticky top-0 h-screen w-64 bg-white p-4 border-r hidden md:block">
      <nav>
        <ul className="space-y-4">
          {data.sections.map((section: any) => (
            <li key={section.label}>
              <button
                onClick={() => {
                  console.log(`scrolling to ${section.label}`)
                  handleScroll(section.label)
                }}
                className="text-gray-700 hover:text-red-500 transition"
              >
                {section.label}
              </button>
            </li>
          ))}
        </ul>
      </nav>
    </aside>
  );
};

export default Sidebar;
