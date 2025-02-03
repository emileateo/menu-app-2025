import styled from '@emotion/styled';
import ItemCard, { ItemCardProps } from "./ItemCard";
import ItemModal from './ItemModal';
import { useState, forwardRef } from 'react';

interface SectionProps {
  id: string;
  label: string;
  description?: string;
  isAvailable: boolean;
  items: {
    id: string;
    label: string;
    price: number;
    description: string;
    availableQuantity: number;
  }[];
}

const SectionContainer = styled.div<{ isAvailable: boolean }>`
  margin-bottom: 2rem;
  position: relative;

  ${({ isAvailable }) =>
    !isAvailable &&
    `
    opacity: 0.5;
    pointer-events: none;
    
    &::after {
      content: "Section Unavailable";
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      background: rgba(255, 255, 255, 0.7);
      color: red;
      padding: 0.5rem 1rem;
      border-radius: 8px;
      font-weight: bold;
    }
  `}
`;

const SectionTitle = styled.h2`
  font-size: 1.5rem;
  font-weight: 600;
`;

const SectionDescription = styled.p`
  color: #6b7280;
`;

const SectionItems = styled.div`
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
  margin-top: 1rem;

  @media (max-width: 768px) {
    grid-template-columns: repeat(2, 1fr);
  }

  @media (max-width: 480px) {
    grid-template-columns: 1fr;
  }
`;

const Section = forwardRef<HTMLDivElement, SectionProps>(
  ({ id, label, description, items, isAvailable }, ref) => {
    const [selectedItem, setSelectedItem] = useState<null | ItemCardProps>(null);

    return (
      <>
        <SectionContainer ref={ref} isAvailable={isAvailable} id={id}>
          <SectionTitle>{label}</SectionTitle>
          {description && <SectionDescription>{description}</SectionDescription>}
          <SectionItems>
            {items.map((item) => (
              <ItemCard key={item.id} {...item} onClick={() => setSelectedItem(item)} />
            ))}
          </SectionItems>
        </SectionContainer>

        <ItemModal isOpen={!!selectedItem} onClose={() => setSelectedItem(null)} item={selectedItem} />
      </>
    );
  }
);

export default Section;
