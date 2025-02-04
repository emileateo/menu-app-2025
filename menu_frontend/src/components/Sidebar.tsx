import styled from '@emotion/styled';
import { motion } from 'framer-motion';
import { useCart } from '../contexts/CartContext';
import { useState, useEffect } from 'react';
import CartModal from './CartModal';

interface SidebarProps {
  sections: {
    label: string;
    id: number;
    description: string;
    displayOrder: number;
  }[];
  onSectionClick: (section: string) => void;
  isOpen: boolean;
  activeSection: number;
}

const SidebarContainer = styled(motion.div)<{ isOpen: boolean }>`
  background-color: #ffffff;
  box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
  z-index: 1000;
  overflow-y: auto;
  transition: all 0.3s ease;

  @media screen and (min-width: 750px) {
    width: 250px;
    height: 100vh;
    position: fixed;
    top: 0;
    left: 0;
    padding: 1rem;
    display: flex;
    align-content: space-around;
    flex-direction: column;
    justify-content: space-around;
  }

  @media screen and (max-width: 749px) {
    width: 100%;
    height: 5rem;
    position: fixed;
    top: 0;
    left: 0;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  }
`;

const SidebarListContainer = styled.div`
  display: flex;
  flex-direction: column;
  width: 100%;
`;

const SidebarList = styled(motion.ul)<{ isExpanded: boolean; isMobile: boolean }>`
  list-style: none;
  padding: 0;
  margin: 0;
  background-color: ${({ isMobile, isExpanded }) => (isMobile && isExpanded ? '#f7f7f7' : 'transparent')};
  
  transition: transform 0.3s ease, opacity 0.3s ease;
  transform: ${({ isMobile, isExpanded }) => (isMobile && isExpanded ? 'translateY(0)' : 'translateY(-20px)')};
  opacity: ${({ isMobile, isExpanded }) => (!isMobile || isExpanded ? 1 : 0)};
  
  @media screen and (min-width: 750px) {
    display: block;
  }

  @media screen and (max-width: 749px) {
    width: 100%;
    position: fixed;
    margin-top: calc(5rem - 5px);
    left: 0;
  }
`;

const SidebarItem = styled.li<{ isActive: boolean; isExpanded: boolean; isMobile: boolean }>`
  font-size: 1.2rem;
  padding: 12px;
  cursor: pointer;
  color: #333;
  transition: background-color 0.2s ease;
  text-align: left;

  background-color: ${({ isActive }) => (isActive ? '#7DAAFF' : 'transparent')};
  opacity: ${({ isMobile, isExpanded }) => (!isMobile || isExpanded ? 1 : 0)};
  transition: transform 0.3s ease, opacity 0.3s ease;
  transform: ${({ isMobile, isExpanded }) => (isMobile && isExpanded ? 'translateY(0)' : 'translateY(-20px)')};
  
  font-weight: ${({ isActive }) => (isActive ? 'bold' : 'normal')};

  &:hover {
    background-color: #f0f0f0;
  }

  @media screen and (max-width: 749px) {
    width: 100%;
    font-size: 90%;
  }
`;

const ToggleButton = styled.button`
  width: fit-content;
  background: none;
  border: none;
  cursor: pointer;
  color: black;
  font-size: 1.5rem;
  margin-bottom: 8px;

  &:hover {
    border: none;
  }
  &:focus {
    border: none;
    outline: none;
  }

  @media screen and (min-width: 750px) {
    display: none;
  }
`;

const CartButton = styled.button`
  margin: 16px;
  padding: 12px;
  background-color: #e0e0e0;
  color: black;
  border-radius: 8px;
  border: none;
  cursor: pointer;
  font-size: 1.2rem;

  &:hover {
    background-color: #f0f0f0;
  }

  @media screen and (max-width: 749px) {
    padding: 8px;
    font-size: 1.5rem;
    border-radius: 8px;
    width: 3rem;
    height: 3rem;
  }
`;

const Sidebar = ({ sections, onSectionClick, isOpen, activeSection }: SidebarProps) => {
  const { quantityIncludingDuplicates } = useCart();
  const [isCartOpen, setIsCartOpen] = useState(false);
  const [isExpanded, setIsExpanded] = useState(false);
  const [isMobile, setIsMobile] = useState(window.innerWidth < 750);

  useEffect(() => {
    const handleResize = () => setIsMobile(window.innerWidth < 750);
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  const totalItems = quantityIncludingDuplicates();

  return (
    <SidebarContainer isOpen={isOpen}>
      <SidebarListContainer>
        {isMobile && (
          <ToggleButton onClick={() => setIsExpanded(!isExpanded)}>
            {isExpanded ? '▼ Menu' : '▶ Menu'}
          </ToggleButton>
        )}

        <SidebarList
          isMobile={isMobile}
          isExpanded={isExpanded || !isMobile}
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          >
          {sections.map((section) => (
            <SidebarItem
              isMobile={isMobile}
              isExpanded={isExpanded || !isMobile}
              isActive={activeSection === section.id}
              key={section.label}
              onClick={() => {
                onSectionClick(section.id.toString());
                if (isMobile) setIsExpanded(false);
              }}
            >
              {section.label}
            </SidebarItem>
          ))}
        </SidebarList>
      </SidebarListContainer>

      <CartButton onClick={() => setIsCartOpen(true)}>
        {isMobile ? '🛒' : `🛒 Cart (${totalItems})`}
      </CartButton>

      {isCartOpen && <CartModal onClose={() => setIsCartOpen(false)} />}
    </SidebarContainer>
  );
};

export default Sidebar;
