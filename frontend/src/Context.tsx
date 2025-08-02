import {
  createContext,
  useState,
  useContext,
  ReactNode,
  FC,
  Dispatch,
  SetStateAction,
  useEffect,
} from "react";
import { Fruit, Fruits } from "./data/types";
import { Filters } from "./data/types";

type SetFruits = Dispatch<SetStateAction<Fruits>>;
//type SetFruit = Dispatch<SetStateAction<Fruit>>;
type SetFilters = Dispatch<SetStateAction<Filters>>;

interface StoreContext {
  fruits: Fruits;
  setFruits: SetFruits;
  //fruit: Fruit;
  //setFruit: SetFruit;
  filters: Filters;
  setFilters: SetFilters;
}

interface StoreContextProviderProps {
  children: ReactNode;
}

const StoreContext = createContext<StoreContext | null>(null);

// eslint-disable-next-line react-refresh/only-export-components
export const useStoreContext = () => {
  return useContext(StoreContext);
};

export const StoreContextProvider: FC<StoreContextProviderProps> = ({ children }) => {
  //const [fruits, setFruits] = useState<Fruits>(initialFruits);
  const [fruits, setFruits] = useState<Fruits>([]);
  //const [fruit, setFruit] = useState<Fruit>(undefined);
  const [filters, setFilters] = useState<Filters>({
    colors: [],
    families: [],
    favorite: false,
    query: "",
    vitamins: []
  });

  const fetchFruits = async () => {
    try{
      const res = await fetch('http://127.0.0.1:5000/fruits')
      const fruits = (await res.json()).map((fruit: Fruit) => ({
        ...fruit,
        price : Number(fruit.price)
      }))
      setFruits(fruits)
    }catch(err) {
      console.log('Error fetchnig fruits : ', err)
    }
  }
  
  const fetchFilters = async () => {
    try{
      const families = (await (await fetch('http://127.0.0.1:5000/families')).json()).map((filter: any) => ({
        ...filter,
        isChecked: false,
      }))
      const colors = (await (await fetch('http://127.0.0.1:5000/colors')).json()).map((filter: any) => ({
        ...filter,
        isChecked: false,
      }))
      const vitamins = (await (await fetch('http://127.0.0.1:5000/vitamins')).json()).map((filter: any) => ({
        ...filter,
        isChecked: false,
      }))
      setFilters({families, colors, vitamins, favorite: false, query: ""})
    }catch(err) {
      console.log('Error fetchnig fruits : ', err)
    }
  }


  useEffect(() => {
    fetchFruits()
    fetchFilters()
  }, [])

  return (
    <StoreContext.Provider value={{ fruits, setFruits, filters, setFilters }}>
      {children}
    </StoreContext.Provider>
  );
};
