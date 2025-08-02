import { useStoreContext } from "../../../Context";
import styles from "./EditQuantity.module.css";
import MinusIcon from "../../../icons/MinusIcon";
import PlusIcon from "../../../icons/PlusIcon";
import axios from "axios";

const EditQuantity = ({ fruit }) => {
  const { setFruits } = useStoreContext();
  const { quantity, id } = fruit;

  const handleMinusClick = () => {
    const newQuantity = Math.max(quantity - 1, 1);
    axios.put('http://127.0.0.1:5000/fruits/decrease/' + id)
    setFruits((prevFruits) =>
      prevFruits.map((f) => (f.id === id ? { ...f, quantity: newQuantity } : f))
    );
  };

  const handlePlusClick = () => {
    const newQuantity = quantity + 1;
    axios.put('http://127.0.0.1:5000/fruits/increase/' + id)
    setFruits((prevFruits) =>
      prevFruits.map((f) => (f.id === id ? { ...f, quantity: newQuantity } : f))
    );
  };

  return (
    <div className={styles.editQuantity}>
      <div className={styles.editButton} onClick={handleMinusClick}>
        <MinusIcon className={styles.icon} />
      </div>
      <div className={styles.number}>{quantity}</div>
      <div className={styles.editButton} onClick={handlePlusClick}>
        <PlusIcon className={styles.icon} />
      </div>
    </div>
  );
};

export default EditQuantity;
