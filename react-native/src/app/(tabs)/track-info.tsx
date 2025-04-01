import { FC, useState } from "react";
import { Text } from "react-native";

const TrackInfo: FC = () => {
  const [isLoading, setIsLoading] = useState(true);
  const [trackInfo, setTrackInfo] = useState<Track>();

  return <Text>This is track info</Text>;
};

export default TrackInfo;
