import { Link, Stack } from "expo-router";
import { FC } from "react";
import { View, StyleSheet, Text } from "react-native";

const NotFoundScreen: FC = () => (
  <>
    <Stack.Screen options={{ title: "404 - Not Found" }} />
    <View style={styles.container}>
      <Text style={styles.message}>
        I see you were trying to find the Z Main. Unfortunately, that&apos;s not
        running today.
      </Text>
      <Link href="/" style={styles.link}>
        Go back home for some other great racing.
      </Link>
    </View>
  </>
);

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    padding: 20,
    backgroundColor: "#f5f5f5",
  },
  message: {
    fontSize: 16,
    textAlign: "center",
    marginBottom: 20,
  },
  link: {
    fontSize: 16,
    color: "#007bff",
    textDecorationLine: "underline",
  },
});

export default NotFoundScreen;
