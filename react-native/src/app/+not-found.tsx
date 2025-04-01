import { Link, Stack } from "expo-router";
import { FC } from "react";
import { View } from "react-native";

const NotFoundScreen: FC = () => (
  <>
    <Stack.Screen options={{ title: "404 - Not Found" }} />
    <View>
      I see you were trying to find the Z Main. Unfortunately, that's not
      running today.
      <Link href="/">Go back home for some other great racing.</Link>
    </View>
  </>
);

export default NotFoundScreen;
