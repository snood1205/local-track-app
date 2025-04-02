import { md5key } from "@/src/lib/md5-key";
import { VendorWithMenu } from "@/src/models";

import { Link } from "expo-router";
import { camelize, capitalize } from "inflection";
import { FC, Fragment, useEffect, useState } from "react";
import {
  ActivityIndicator,
  FlatList,
  ListRenderItem,
  StyleSheet,
  Text,
  View,
} from "react-native";

const renderItem: ListRenderItem<[string, VendorWithMenu[]]> = ({ item }) => {
  return (
    <View key={md5key(item, "view")} style={styles.categoryContainer}>
      <Text key={md5key(item, "title")} style={styles.categoryTitle}>
        {item[0]}
      </Text>
      <View
        style={{
          borderBottomColor: "#ccc",
          borderBottomWidth: 1,
          marginVertical: 10,
        }}
      />
      {item[1].map((vendor) => (
        <Fragment key={md5key(vendor, "vendor-fragment")}>
          <Text key={md5key(vendor, "vendor.slug")} style={styles.vendorName}>
            {vendor.name}
          </Text>
          {Object.keys(vendor.menu).map((heading) => (
            <Fragment key={md5key(heading, "heading-fragment")}>
              {heading !== "*" && (
                <Text
                  key={md5key(heading, "heading-text")}
                  style={styles.menuHeading}
                >
                  {capitalize(heading)}
                </Text>
              )}
              {vendor.menu[heading].map((menuItem) => (
                <Fragment key={md5key(menuItem, "menu-item-fragment")}>
                  <Link
                    href={{
                      pathname: "/vendors/buy",
                      params: { item: camelize(menuItem.name) },
                    }}
                    key={md5key(menuItem, "menu-item-name")}
                    style={styles.menuItemName}
                  >
                    {menuItem.name}
                  </Link>
                  <Text
                    key={md5key(menuItem, "menu-item-price")}
                    style={styles.menuItemPrice}
                  >
                    {menuItem.price}
                  </Text>
                  <Text
                    key={md5key(menuItem, "menu-item-description")}
                    style={styles.menuItemDescription}
                  >
                    {menuItem.description}
                  </Text>
                </Fragment>
              ))}
            </Fragment>
          ))}
        </Fragment>
      ))}
    </View>
  );
};

const Vendors: FC = () => {
  const [isLoading, setLoading] = useState(true);
  const [vendors, setVendors] = useState<Record<string, VendorWithMenu[]>>();
  const fetchVendors = async () => {
    const url = `${process.env.EXPO_PUBLIC_API_URL}/vendors/grouped/include-menu`;
    const response = await fetch(url);
    const json = await response.json();
    setVendors(json);
    setLoading(false);
  };

  useEffect(() => {
    fetchVendors();
  }, []);

  return (
    <View>
      {isLoading ? (
        <ActivityIndicator />
      ) : (
        <FlatList
          data={Object.entries(vendors ?? {})}
          keyExtractor={(item) => md5key(item[0], "base")}
          renderItem={renderItem}
        />
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  categoryContainer: {
    marginBottom: 20,
    padding: 10,
    backgroundColor: "#f9f9f9",
    borderRadius: 8,
  },
  categoryTitle: {
    fontSize: 18,
    fontWeight: "bold",
    marginBottom: 10,
  },
  vendorName: {
    fontSize: 16,
    fontWeight: "600",
    marginTop: 10,
  },
  menuHeading: {
    fontSize: 14,
    fontWeight: "bold",
    marginTop: 10,
  },
  menuItemName: {
    fontSize: 14,
    marginTop: 5,
  },
  menuItemPrice: {
    fontSize: 14,
    color: "#888",
  },
  menuItemDescription: {
    fontSize: 12,
    color: "#666",
  },
});

export default Vendors;
