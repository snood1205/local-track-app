import { FC } from "react";
import { Text, View, StyleSheet } from "react-native";

const Home: FC = () => (
  <View style={styles.container}>
    <Text style={styles.title}>Home</Text>
  </View>
);

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#f5f5f5",
  },
  title: {
    fontSize: 24,
    fontWeight: "bold",
  },
});

export default Home;
