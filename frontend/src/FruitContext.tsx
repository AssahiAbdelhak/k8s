import { createContext, Dispatch, SetStateAction, useContext, useEffect, useState } from 'react';
import { Filters, Fruit, Fruits } from "./data/types";
import { initialFilters } from "./data/filters";

type SetFilters = Dispatch<SetStateAction<Filters>>;
type SetFruits = Dispatch<SetStateAction<Fruits>>;

interface FruitContextType {
    fruits: Fruit[];
    setFruits: SetFruits;
    filters: Filters;
    setFilters: SetFilters;
    loading: Boolean;
    refresh: () => void;
}

const FruitContext = createContext<FruitContextType | undefined>(undefined);

export const useFruits = (): FruitContextType => useContext(FruitContext);

export const FruitProvider: React.FC<{children: React.ReactNode}> = ({ children }) => {
    const [fruits, setFruits] = useState<Fruit[]>([]);
    const [loading, setLoading] = useState<Boolean>(true);
    const [filters, setFilters] = useState<Filters>(initialFilters);

    const fetchFruits = async () => {
        try {
            setLoading(true);
            const res = await fetch('http://127.0.0.1:5000/fruits');
            const data = await res.json();
            setFruits(data.fruits);
        } catch (err) {
            console.error('Error fetching fruits:', err);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchFruits();
    }, []);

    return (
        <FruitContext.Provider value={{ fruits, setFruits, filters, setFilters,loading, refresh: fetchFruits }}>
            {children}
        </FruitContext.Provider>
    );
};
