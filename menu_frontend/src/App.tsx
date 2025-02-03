import styled from '@emotion/styled';
import MenuPage from "./pages/MenuPage";
import './App.css'
import { CartProvider } from './contexts/CartContext';
import { gql, useQuery } from '@apollo/client';
import { useRef, useState } from 'react';
import Sidebar from './components/Sidebar';

export const Content = styled.div`
  display: flex;
  flex-direction: column;

  @media screen and (min-width: 750px) {
    flex-direction: row; /* Sidebar on the left, content on the right */
  }
`;

export const MainContent = styled.div`
  flex-grow: 1;
  padding: 15px 20px;

  @media screen and (min-width: 750px) {
    margin-left: 250px; /* Leave space for sidebar */
  }
`;

const GET_SECTIONS = gql`
  query GetSections {
    sections {
      id
      label
      description
    }
  }
`;

function App() {
  const { loading, error, data } = useQuery(GET_SECTIONS);

  console.log('data', data);
  
  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error.message}</p>;
    
  const sections = data?.sections?.map(
    (section: any) => ({
      id: section.id,
      label: section.label,
    })
  ) || [];
  
  console.log('sections', sections);

  const sectionRefs = useRef<Record<string, HTMLElement | null>>({});
  const [activeSection, setActiveSection] = useState(sections[0]?.id || "");

  // useEffect(() => {
  //   if (Object.keys(sectionRefs.current).length === 0) return;
  
  //   const observer = new IntersectionObserver(
  //     (entries) => {
  //       entries.forEach((entry) => {
  //         if (entry.isIntersecting) {
  //           setActiveSection(Number(entry.target.id));
  //           entry.target.classList.add('active'); 
  //         } else {
  //           entry.target.classList.remove('active'); 
  //         }
  //       });
  //     },
  //     { rootMargin: "0px 0px -99% 0px", threshold: 0 }
  //   );
  
  //   Object.values(sectionRefs.current).forEach((section) => {
  //     if (section) {
  //       observer.observe(section);
  //     }
  //   });
  
  //   return () => observer.disconnect();
  // }, [sections]);

  const handleSectionClick = (sectionId: string) => {
    const sectionElement = sectionRefs.current[sectionId];
    setActiveSection(sectionId);

    if (sectionElement) {
      sectionElement.scrollIntoView({ behavior: "smooth", block: "start" });
    }
  };

  return (
    <CartProvider>
      <Content>
        <Sidebar sections={sections} isOpen={true} onSectionClick={handleSectionClick} activeSection={activeSection} />
        <MainContent>
          <MenuPage sectionRefs={sectionRefs} setActiveSection={setActiveSection} />
        </MainContent>
      </Content>
    </CartProvider>
  );
}


export default App
