export interface Restaurant {
  id: string;
  name: string;
  address: string;
  phone: string;
  cuisine: string;
  menuItems: string[];
}

export const restaurants: Restaurant[] = [
  {
    id: "MCDONALDS_MAIN_ST",
    name: "MCDONALDS MAIN ST",
    address: "123 MAIN ST",
    phone: "555-0123",
    cuisine: "FAST_FOOD",
    menuItems: ["BIG MAC", "FRIES", "COKE", "CHICKEN NUGGETS", "APPLE PIE"]
  },
  {
    id: "PIZZA_HUT_DOWNTOWN",
    name: "PIZZA HUT DOWNTOWN",
    address: "456 DOWNTOWN AVE",
    phone: "555-PIZZA",
    cuisine: "PIZZA",
    menuItems: ["PEPPERONI PIZZA LG", "CHEESE PIZZA MED", "BREADSTICKS", "WINGS"]
  },
  {
    id: "STARBUCKS_5TH_AVE",
    name: "STARBUCKS 5TH AVE",
    address: "789 5TH AVENUE",
    phone: "555-COFFEE",
    cuisine: "COFFEE",
    menuItems: ["LATTE", "CAPPUCCINO", "MUFFIN", "SANDWICH"]
  },
  {
    id: "BURGER_KING_WEST",
    name: "BURGER KING WEST",
    address: "321 WEST ST",
    phone: "555-KING",
    cuisine: "FAST_FOOD",
    menuItems: ["WHOPPER", "CHICKEN SANDWICH", "ONION RINGS", "SHAKE"]
  },
  {
    id: "TACO_BELL_CENTRAL",
    name: "TACO BELL CENTRAL",
    address: "654 CENTRAL BLVD",
    phone: "555-TACO",
    cuisine: "MEXICAN",
    menuItems: ["TACO SUPREME", "BURRITO", "NACHOS", "QUESADILLA"]
  }
];

export const deliveryZones = {
  "ZONE_A": ["MCDONALDS_MAIN_ST", "PIZZA_HUT_DOWNTOWN"],
  "ZONE_B": ["STARBUCKS_5TH_AVE", "BURGER_KING_WEST"],
  "ZONE_C": ["TACO_BELL_CENTRAL"]
};

export const orderCategories = {
  "BREAKFAST": ["STARBUCKS_5TH_AVE", "MCDONALDS_MAIN_ST"],
  "LUNCH": ["MCDONALDS_MAIN_ST", "BURGER_KING_WEST", "TACO_BELL_CENTRAL"],
  "DINNER": ["PIZZA_HUT_DOWNTOWN", "TACO_BELL_CENTRAL"],
  "LATE_NIGHT": ["TACO_BELL_CENTRAL", "PIZZA_HUT_DOWNTOWN"]
};

export function getRandomRestaurant(): Restaurant {
  return restaurants[Math.floor(Math.random() * restaurants.length)];
}

export function getRestaurantById(id: string): Restaurant | undefined {
  return restaurants.find(r => r.id === id);
}

export function getRestaurantsByZone(zone: string): Restaurant[] {
  const restaurantIds = deliveryZones[zone as keyof typeof deliveryZones] || [];
  return restaurantIds.map(id => getRestaurantById(id)).filter(Boolean) as Restaurant[];
}
