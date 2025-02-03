import styled from "@emotion/styled";
import { motion } from "framer-motion";

interface ItemModalProps {
  isOpen: boolean;
  onClose: () => void;
  item: {
    id: string;
    label: string;
    description: string;
    price: number;
    availableQuantity: number;
  } | null;
}

const ModalOverlay = styled(motion.div)`
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
`;

const ModalContent = styled(motion.div)`
  background: white;
  padding: 2rem;
  border-radius: 12px;
  width: 90%;
  max-width: 500px;
  text-align: center;
  position: relative;
`;

const CloseButton = styled.button`
  position: absolute;
  top: 10px;
  right: 10px;
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
`;

const ItemImage = styled.img`
  width: 100%;
  max-height: 300px;
  object-fit: cover;
  border-radius: 8px;
`;

const AddToCartButton = styled.button<{ unavailable?: boolean }>`
  background-color: ${({ unavailable }) => (unavailable ? "#e1e1e1" : "#f95553")};
  color: ${({ unavailable }) => (unavailable ? "#888" : "white")};
  border: none;
  padding: 12px;
  border-radius: 4px;
  width: 100%;
  cursor: ${({ unavailable }) => (unavailable ? "not-allowed" : "pointer")};
  transition: background-color 0.3s ease;

  &:hover {
    background-color: ${({ unavailable }) => (unavailable ? "#e1e1e1" : "#e67e22")};
  }
`;

const ItemModal = ({ isOpen, onClose, item }: ItemModalProps) => {
  if (!isOpen || !item) return null;

  return (
    <ModalOverlay
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      onClick={onClose}
    >
      <ModalContent
        initial={{ y: 50, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        exit={{ y: -50, opacity: 0 }}
        onClick={(e) => e.stopPropagation()}
      >
        <CloseButton onClick={onClose}>&times;</CloseButton>
        <ItemImage src="https://mrskueh.com/assets/images/atlas-core-active-storage/zw8m8fyv92m145ysfrt70ckz245u" alt={item.label} />
        <h2>{item.label}</h2>
        <p>{item.description}</p>
        <p>${item.price.toFixed(2)}</p>
        <AddToCartButton unavailable={item.availableQuantity === 0}>
          {item.availableQuantity === 0 ? "Out of Stock" : "Add to Cart"}
        </AddToCartButton>
      </ModalContent>
    </ModalOverlay>
  );
};

export default ItemModal;
