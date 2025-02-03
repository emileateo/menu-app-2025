import { useCart } from "../contexts/CartContext";
import { motion } from "framer-motion";
import styled from "@emotion/styled";

interface CartModalProps {
  onClose: () => void;
}

const Overlay = styled(motion.div)`
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: flex-end;
  z-index: 1000;
`;

const ModalContainer = styled(motion.div)`
  width: 320px;
  height: 100vh;
  background: white;
  box-shadow: -4px 0 10px rgba(0, 0, 0, 0.2);
  padding: 20px;
  display: flex;
  flex-direction: column;
`;

const CloseButton = styled.button`
  align-self: flex-end;
  background: none;
  border: none;
  font-size: 20px;
  cursor: pointer;
`;

const CartItem = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  margin-bottom: 12px;
  border: #2F2F2F;
  border-width: 10px;
`;
  
const CartItemDetails = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between; 
  text-align: left;
`;
  
const ItemQuantityDetails = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
`;
  
const PlusMinusControls = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  width: 100px;
  justify-content: space-between;
`;
  
const PlusMinusButton = styled.button`
  color: #000000;
  background-color: #f0f0f0;
  border: 1px solid #ccc;
  padding: 5px 10px;
  font-size: 16px;
  cursor: pointer;
  &:disabled {
    color:rgba(240, 240, 240, 0.74);
    background-color:rgb(161, 161, 161);
    cursor: not-allowed;
  }
`;

const QuantityText = styled.span`
  font-size: 16px;
  font-weight: bold;
  padding: 0 10px; /* Add some spacing between buttons and quantity */
`;

const CartModal = ({ onClose }: CartModalProps) => {
  const { cart, removeFromCart, updateQuantity } = useCart();
  const totalPrice = cart.reduce((sum, item) => sum + item.price * item.quantity, 0);

  return (
    <Overlay
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      onClick={onClose}
    >
      <ModalContainer
        initial={{ x: "100%" }}
        animate={{ x: 0 }}
        exit={{ x: "100%" }}
        transition={{ type: "spring", stiffness: 300, damping: 30 }}
        onClick={(e) => e.stopPropagation()} // Prevent closing when clicking inside
      >
        <CloseButton onClick={onClose}>✕</CloseButton>
        <h2>Your Cart</h2>

        {cart.length === 0 ? (
            <p>Your cart is empty.</p>
        ) : (
            <>
              {cart.map((item) => (
              <CartItem
                  key={item.id}
              >
                  <CartItemDetails>
                    <p>{item.label}</p>
                    <p>${item.price.toFixed(2)}</p>
                  </CartItemDetails>
                  <ItemQuantityDetails>
                    <PlusMinusControls>
                      <PlusMinusButton onClick={() => updateQuantity(item.id, item.quantity - 1)} disabled={item.quantity === 1}>
                          -
                      </PlusMinusButton>
                      <QuantityText>{item.quantity}</QuantityText>
                      <PlusMinusButton onClick={() => updateQuantity(item.id, item.quantity + 1)}>
                          +
                      </PlusMinusButton>
                    </PlusMinusControls>
                    <button onClick={() => removeFromCart(item.id)} style={{ marginLeft: "8px", color: "red", backgroundColor: "white" }}>
                        ✕
                    </button>
                  </ItemQuantityDetails>
              </CartItem>
              ))}
              
              <h3>Total: ${totalPrice.toFixed(2)}</h3>
              <button
              style={{
                  marginTop: "16px",
                  padding: "10px",
                  backgroundColor: "#28a745",
                  color: "white",
                  cursor: "pointer",
                  borderRadius: "8px",
              }}
              >
              Checkout
              </button>
            </>
        )}
      </ModalContainer>
    </Overlay>
  );
};

export default CartModal;
