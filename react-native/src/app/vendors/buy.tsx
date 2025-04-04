import { fetchWithLoading } from "@/src/lib/fetch-with-loading";
import { MenuItem } from "@/src/models";
import { useGlobalSearchParams } from "expo-router";
import { FC, useEffect, useState } from "react";
import { ActivityIndicator, StyleSheet, Text, View } from "react-native";

const Buy: FC = () => {
  const globalParams = useGlobalSearchParams();
  const slug = globalParams.item as string;
  const [item, setItem] = useState<MenuItem>();
  const [isLoading, setLoading] = useState(true);

  const fetchItem = fetchWithLoading(`/items/${slug}`, setItem, setLoading);

  useEffect(() => {
    fetchItem();
  }, []);

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Buy Item</Text>
      {isLoading ? (
        <ActivityIndicator />
      ) : (
        <View style={{ alignItems: "center" }}>
          <Text style={styles.itemName}>{item?.name}</Text>
          <Text>{`Price: ${item?.price}`}</Text>
          {item?.description && (
            <Text>{`Description: ${item?.description}`}</Text>
          )}
        </View>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    padding: 20,
    backgroundColor: "#fff",
  },
  title: {
    fontSize: 24,
    fontWeight: "bold",
    marginBottom: 20,
  },
  itemName: {
    fontSize: 18,
    color: "#333",
  },
});

export default Buy;
