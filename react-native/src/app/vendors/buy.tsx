import { useGlobalSearchParams } from "expo-router";
import { FC } from "react";
import { StyleSheet, Text, View } from "react-native";

const Buy: FC = () => {
  const globalParams = useGlobalSearchParams();
  const slug = globalParams.item as string;

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Buy Item</Text>
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
