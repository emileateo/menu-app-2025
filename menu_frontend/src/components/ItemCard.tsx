import styled from '@emotion/styled';
import { motion } from 'framer-motion';
import { useCart } from '../contexts/CartContext';

export interface ItemCardProps {
  id: string;
  label: string;
  description: string;
  price: number;
  availableQuantity: number;
  imageUrl: string;
  unavailable?: boolean;
}

const StyledItemCard = styled(motion.div)<{ unavailable?: boolean }>`
  height: 460px;
  border: 1px solid #e1e1e1;
  border-radius: 8px;
  overflow: hidden;
  cursor: pointer;
  opacity: ${({ unavailable }) => (unavailable ? 0.5 : 1)};
  transition: opacity 0.3s ease;
  background-color: white;
`;

const ImageContainer = styled(motion.div)`
  height: 200px;
  overflow: hidden;
`;

const TextContainer = styled.div`
  padding: 16px;
  text-align: center;
`;

const ItemDescription = styled.p`
  display: -webkit-box;
  -webkit-line-clamp: 2; /* Limit to 2 lines */
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  margin: 8px 0; /* Add some spacing for clarity */
`;

const AddToCartButton = styled.button<{ unavailable?: boolean }>`
  background-color: ${({ unavailable }) => (unavailable ? '#e1e1e1' : '#f95553')};
  color: ${({ unavailable }) => (unavailable ? '#888' : 'white')};
  border: none;
  padding: 12px;
  border-radius: 4px;
  width: 100%;
  cursor: ${({ unavailable }) => (unavailable ? 'not-allowed' : 'pointer')};
  transition: background-color 0.3s ease;
  &:hover {
    background-color: ${({ unavailable }) => (unavailable ? '#e1e1e1' : '#c84442')};
  }
`;

const ItemCard = ({ id, label, description, price, availableQuantity, imageUrl, onClick }: ItemCardProps & { onClick: () => void }) => {
  const { addToCart } = useCart();

  return (
    <StyledItemCard
      whileTap={{ scale: 0.95 }}
      transition={{ duration: 0.3 }}
      unavailable={availableQuantity === 0}
      onClick={onClick}
    >
      <ImageContainer
        whileHover={{ scale: 1.05 }}
      >
        <img
          src={imageUrl}
          alt={label}
          className="item-image"
          style={{width: "-webkit-fill-available"}}
        />
      </ImageContainer>
      <TextContainer>
        <h3>{label}</h3>
        <ItemDescription>{description}</ItemDescription>
        <p>${price.toFixed(2)}</p>
        <AddToCartButton
          unavailable={availableQuantity === 0}
          onClick={(e) => {
            e.stopPropagation(); // Prevent the modal from opening
            addToCart({ id: id, label: label, price: price, quantity: 1 });
          }}>
          {availableQuantity === 0 ? "Out of Stock" : "Add to Cart"}
        </AddToCartButton>
      </TextContainer>
    </StyledItemCard>
  );
};


export default ItemCard;
