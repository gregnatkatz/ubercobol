# COBOL UberEats Emulator - Patty's Food Tracker

A nostalgic COBOL-style terminal emulator for tracking Uber Eats orders, built for former COBOL programmers who want some fun! 💚

## Screenshots

### 3270 Terminal Interface
![COBOL UberEats Terminal Interface](/home/ubuntu/screenshots/localhost_5173_155000.png)

*Authentic IBM 3270 terminal styling with green-on-black display, COBOL UBER EATS ASCII art logo, and classic mainframe function keys*

### Restaurant Management System
![Restaurant Management Interface](/home/ubuntu/screenshots/localhost_5173_155040.png)

*Restaurant database management with COBOL-style data structures showing current restaurants and instructions for adding new ones*

## Features

- 🖥️ Authentic IBM 3270 terminal interface with green-on-black styling
- 📋 Interactive order management system
- 📊 Real-time statistics with ASCII bar charts
- 💻 COBOL source code viewer with multiple programs
- ⌨️ Command-line interface that responds to user input
- 🔄 Order status progression (Pending → Preparing → Ready → Delivered)
- 🌐 **Web interface for COBOL editing** - Edit code in your browser!
- 🏪 **Extensible restaurant database** - Add your favorite locations!

## Super Easy Installation (Windows)

### Option 1: One-Click Install (Recommended)
1. **Download this repository** by clicking the green "Code" button above and selecting "Download ZIP"
2. **Extract the ZIP file** to any folder on your computer
3. **Double-click `install.bat`** and follow the prompts
4. **Wait for it to finish** - it will automatically:
   - Check for Node.js (and tell you to install it if needed)
   - Install all dependencies
   - Build the desktop application
   - Build the web version
   - Create a Windows installer
5. **Run the installer** from the `release` folder when it's done
6. **Access the web version** at `http://localhost:3000` after installation

### Option 2: Manual Installation
If you prefer to do it step by step:

1. **Install Node.js** from https://nodejs.org/ (choose the LTS version)
2. **Download and extract this repository**
3. **Open Command Prompt** in the extracted folder
4. **Run these commands:**
   ```cmd
   npm install
   npm run build
   npm run build-web
   npx electron-builder --win --publish=never
   ```
5. **Find the installer** in the `release` folder

## System Requirements

- **Windows 10 or later**
- **Node.js 18 or later** (will be prompted to install if missing)
- **At least 500MB free disk space**

## How to Use

### Desktop Application
Once installed, the COBOL UberEats Emulator will open with an authentic terminal interface.

### Web Interface
Access the web version at `http://localhost:3000` for:
- **Restaurant Management**: Add/edit restaurants through web forms
- **COBOL Code Editing**: Edit COBOL programs in a web-based editor
- **Configuration Management**: Modify app settings without touching code

### Available Commands
- **View Active Orders**: See all current orders with their status
- **Order Statistics**: View delivery metrics and hourly breakdowns
- **Add New Orders**: Create new orders in the system
- **Update Order Status**: Progress orders through their lifecycle
- **View COBOL Source**: Browse the actual COBOL programs
- **Restaurant Manager**: Access restaurant configuration (type 'RESTAURANT')

## 🎯 COBOL Programming Project: Adding Your Favorite Restaurants

**This is your fun coding challenge!** The emulator currently has sample restaurants (McDonald's, Pizza Hut, Starbucks), but you can add your own favorite local spots by modifying the COBOL-style data structures.

### Current Restaurant Data Structure

The restaurants are defined in `src/restaurantData.ts` in this format:

```typescript
interface Restaurant {
  id: string;           // "MCDONALDS_MAIN_ST"
  name: string;         // "MCDONALDS MAIN ST"
  address: string;      // "123 MAIN ST"
  phone: string;        // "555-0123"
  cuisine: string;      // "FAST_FOOD"
  menuItems: string[];  // ["BIG MAC", "FRIES", "COKE"]
}
```

### Your Mission: Add 3 New Restaurants

**Step 1: Choose Your Restaurants**
Pick 3 local restaurants you order from frequently. For each one, you'll need:
- Restaurant name (keep it short, COBOL style)
- Address
- Phone number
- Cuisine type (PIZZA, CHINESE, MEXICAN, ITALIAN, etc.)
- 3-5 popular menu items

**Step 2: Follow COBOL Naming Conventions**
- Use ALL CAPS for names
- Replace spaces with underscores
- Keep names under 20 characters
- Use descriptive but concise identifiers

**Example: Adding "Tony's Pizza Palace"**
```typescript
{
  id: "TONYS_PIZZA_PALACE",
  name: "TONYS PIZZA PALACE", 
  address: "456 ELM STREET",
  phone: "555-PIZZA",
  cuisine: "PIZZA",
  menuItems: [
    "PEPPERONI PIZZA LG",
    "CHEESE PIZZA MED", 
    "GARLIC BREAD",
    "CAESAR SALAD"
  ]
}
```

**Step 3: Edit the Restaurant Data File**
1. Open `src/restaurantData.ts` in any text editor
2. Add your restaurants to the `restaurants` array
3. Follow the existing format exactly
4. Save the file

**Step 4: Test Your Changes**
1. Save your changes
2. Run `npm run dev` to test locally
3. Try adding orders from your new restaurants
4. Make sure the names display correctly in the terminal

### 🏆 Bonus Challenges

**Level 2: Add Delivery Zones**
Create a COBOL-style delivery zone system:
```typescript
const deliveryZones = {
  "ZONE_A": ["TONYS_PIZZA_PALACE", "MCDONALDS_MAIN_ST"],
  "ZONE_B": ["STARBUCKS_5TH_AVE"],
  // Define your zones...
};
```

**Level 3: Create Custom Order Types**
Add special order categories like "BREAKFAST", "LATE_NIGHT", "HEALTHY" and assign restaurants to them.

**Level 4: Use the Web Editor** (Easy Mode)
Instead of editing code directly:
1. Run the application
2. Type 'RESTAURANT' in the terminal
3. Use the web interface to add restaurants
4. Your changes will be saved automatically!

### 📝 Documentation Challenge

Write your own COBOL-style documentation for each restaurant you add:

```cobol
      * RESTAURANT: TONYS PIZZA PALACE
      * LOCATION: 456 ELM STREET  
      * ESTABLISHED: 2024
      * SPECIALTIES: PIZZA, ITALIAN
      * DELIVERY-TIME: 25-35 MINUTES
      * NOTES: BEST PIZZA IN TOWN, FAMILY OWNED
```

### 🎉 Share Your Results

Once you've added your restaurants:
1. Take a screenshot of your custom terminal with the new restaurants
2. Document what you learned about COBOL-style data organization
3. Share any challenges you faced and how you solved them

This project will give you hands-on experience with:
- COBOL naming conventions and data structures
- TypeScript object manipulation
- Terminal-based user interfaces
- Data organization principles from mainframe computing

Have fun coding like it's 1985! 🖥️💚

## Troubleshooting

### "Node.js not found" error
- Download and install Node.js from https://nodejs.org/
- Choose the "LTS" (Long Term Support) version
- Restart your computer after installation
- Run `install.bat` again

### "Permission denied" error
- Right-click on `install.bat` and select "Run as administrator"

### Build fails
- Make sure you have a stable internet connection
- Try running `install.bat` again
- If it still fails, try the manual installation steps

### Web interface not accessible
- Make sure the desktop app is running
- Try accessing `http://localhost:3000` in your browser
- Check that no firewall is blocking the connection

## For Developers

This is an Electron app built with:
- **React + TypeScript** for the frontend
- **Tailwind CSS** for styling
- **Electron** for desktop packaging
- **electron-builder** for creating installers

### Development Commands
```bash
npm run dev          # Start development server
npm run build        # Build for production
npm run build-web    # Build web version
npm run electron     # Run Electron app
npm run dist         # Build installer
npm run serve-web    # Serve web version locally
```

## License

MIT License - Feel free to modify and share!

---

*Built with ❤️ for COBOL programmers everywhere*
