import styled from '@emotion/styled';
import { motion } from 'framer-motion';
import { useCart } from '../contexts/CartContext';
import { useEffect, useState } from 'react';
import CartModal from './CartModal';

interface SidebarProps {
  sections: [{
    label: string;
    id: number;
  }];
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
    height: auto;
    position: fixed;
    top: 0;
    left: 0;
    padding: 1rem;
    display: flex;
    justify-content: center;
    align-items: center;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  }
`;

const SidebarList = styled.ul`
  list-style: none;
  padding: 0;
  margin: 0;

  @media screen and (max-width: 749px) {
    display: flex;
  }
`;

const SidebarItem = styled.li<{ isActive: boolean }>`
  font-size: 1.2rem;
  padding: 12px;
  cursor: pointer;
  color: #333;
  transition: background-color 0.2s ease;
  text-align: left;

  background-color: ${({ isActive }) => (isActive ? '#7DAAFF' : 'transparent')}; /* Apply active background */
  font-weight: ${({ isActive }) => (isActive ? 'bold' : 'normal')}; /* Make active item bold */

  &:hover {
    background-color: #f0f0f0;
  }

  @media screen and (max-width: 749px) {
    width: 20%;
    text-align: center;
    font-size: 80%;
  }
`;

const CartButton = styled.button`
  margin: 16px;
  padding: 12px;
  background-color: #e0e0e0;
  color: black;
  border-radius: 8px;
  border: none;
  cursor: pointe;

  &:hover {
    background-color: #f0f0f0;
  }
`;

const Sidebar = ({ sections, onSectionClick, isOpen, activeSection }: SidebarProps) => {
  const { quantityIncludingDuplicates } = useCart();
  const [isCartOpen, setIsCartOpen] = useState(false);

  const totalItems = quantityIncludingDuplicates();

  return (
    <SidebarContainer isOpen={isOpen}>
      <SidebarList>
        {sections.map((section) => (
          <SidebarItem isActive={activeSection === section.id} key={section.label} onClick={() => onSectionClick(section.id.toString())}>
            {section.label}
          </SidebarItem>
        ))}
      </SidebarList>

      <CartButton 
        onClick={() => setIsCartOpen(true)}
      >
        🛒 Cart ({totalItems})
      </CartButton>

      {isCartOpen && <CartModal onClose={() => setIsCartOpen(false)} />}
    </SidebarContainer>
  );
};

export default Sidebar;
