import React, { useState } from 'react';
import { type Restaurant } from '../restaurantData';

interface RestaurantManagerProps {
  onClose: () => void;
}

export const RestaurantManager: React.FC<RestaurantManagerProps> = ({ onClose }) => {
  const [newRestaurant, setNewRestaurant] = useState<Partial<Restaurant>>({
    id: '',
    name: '',
    address: '',
    phone: '',
    cuisine: '',
    menuItems: []
  });
  const [menuItemInput, setMenuItemInput] = useState('');

  const handleAddMenuItem = () => {
    if (menuItemInput.trim()) {
      setNewRestaurant(prev => ({
        ...prev,
        menuItems: [...(prev.menuItems || []), menuItemInput.trim().toUpperCase()]
      }));
      setMenuItemInput('');
    }
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (newRestaurant.name && newRestaurant.address) {
      const restaurantData = {
        ...newRestaurant,
        id: newRestaurant.name?.replace(/\s+/g, '_').toUpperCase() || '',
        name: newRestaurant.name?.toUpperCase() || '',
        address: newRestaurant.address?.toUpperCase() || '',
        phone: newRestaurant.phone || '',
        cuisine: newRestaurant.cuisine?.toUpperCase() || 'OTHER',
        menuItems: newRestaurant.menuItems || []
      } as Restaurant;

      alert(`RESTAURANT DATA GENERATED:\n\n${JSON.stringify(restaurantData, null, 2)}\n\nCOPY THIS TO src/restaurantData.ts`);
      
      setNewRestaurant({
        id: '',
        name: '',
        address: '',
        phone: '',
        cuisine: '',
        menuItems: []
      });
    }
  };

  return (
    <div style={{ 
      position: 'fixed', 
      top: 0, 
      left: 0, 
      right: 0, 
      bottom: 0, 
      backgroundColor: 'rgba(0, 0, 0, 0.9)',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      zIndex: 1000
    }}>
      <div style={{
        backgroundColor: '#001100',
        border: '2px solid #00ff00',
        padding: '20px',
        maxWidth: '600px',
        width: '90%',
        maxHeight: '80vh',
        overflowY: 'auto',
        color: '#00ff00',
        fontFamily: 'monospace'
      }}>
        <div style={{ fontSize: '18px', marginBottom: '20px', textAlign: 'center' }}>
          RESTAURANT CONFIGURATION UTILITY
        </div>
        
        <form onSubmit={handleSubmit}>
          <div style={{ marginBottom: '15px' }}>
            <label style={{ display: 'block', marginBottom: '5px' }}>RESTAURANT NAME:</label>
            <input
              type="text"
              value={newRestaurant.name || ''}
              onChange={(e) => setNewRestaurant(prev => ({ ...prev, name: e.target.value }))}
              style={{
                width: '100%',
                padding: '5px',
                backgroundColor: '#003300',
                color: '#00ff00',
                border: '1px solid #00ff00',
                fontFamily: 'monospace'
              }}
              placeholder="TONYS PIZZA PALACE"
            />
          </div>

          <div style={{ marginBottom: '15px' }}>
            <label style={{ display: 'block', marginBottom: '5px' }}>ADDRESS:</label>
            <input
              type="text"
              value={newRestaurant.address || ''}
              onChange={(e) => setNewRestaurant(prev => ({ ...prev, address: e.target.value }))}
              style={{
                width: '100%',
                padding: '5px',
                backgroundColor: '#003300',
                color: '#00ff00',
                border: '1px solid #00ff00',
                fontFamily: 'monospace'
              }}
              placeholder="456 ELM STREET"
            />
          </div>

          <div style={{ marginBottom: '15px' }}>
            <label style={{ display: 'block', marginBottom: '5px' }}>PHONE:</label>
            <input
              type="text"
              value={newRestaurant.phone || ''}
              onChange={(e) => setNewRestaurant(prev => ({ ...prev, phone: e.target.value }))}
              style={{
                width: '100%',
                padding: '5px',
                backgroundColor: '#003300',
                color: '#00ff00',
                border: '1px solid #00ff00',
                fontFamily: 'monospace'
              }}
              placeholder="555-PIZZA"
            />
          </div>

          <div style={{ marginBottom: '15px' }}>
            <label style={{ display: 'block', marginBottom: '5px' }}>CUISINE TYPE:</label>
            <select
              value={newRestaurant.cuisine || ''}
              onChange={(e) => setNewRestaurant(prev => ({ ...prev, cuisine: e.target.value }))}
              style={{
                width: '100%',
                padding: '5px',
                backgroundColor: '#003300',
                color: '#00ff00',
                border: '1px solid #00ff00',
                fontFamily: 'monospace'
              }}
            >
              <option value="">SELECT CUISINE</option>
              <option value="FAST_FOOD">FAST FOOD</option>
              <option value="PIZZA">PIZZA</option>
              <option value="CHINESE">CHINESE</option>
              <option value="MEXICAN">MEXICAN</option>
              <option value="ITALIAN">ITALIAN</option>
              <option value="COFFEE">COFFEE</option>
              <option value="OTHER">OTHER</option>
            </select>
          </div>

          <div style={{ marginBottom: '15px' }}>
            <label style={{ display: 'block', marginBottom: '5px' }}>MENU ITEMS:</label>
            <div style={{ display: 'flex', marginBottom: '10px' }}>
              <input
                type="text"
                value={menuItemInput}
                onChange={(e) => setMenuItemInput(e.target.value)}
                style={{
                  flex: 1,
                  padding: '5px',
                  backgroundColor: '#003300',
                  color: '#00ff00',
                  border: '1px solid #00ff00',
                  fontFamily: 'monospace',
                  marginRight: '10px'
                }}
                placeholder="PEPPERONI PIZZA LG"
              />
              <button
                type="button"
                onClick={handleAddMenuItem}
                style={{
                  padding: '5px 10px',
                  backgroundColor: '#004400',
                  color: '#00ff00',
                  border: '1px solid #00ff00',
                  cursor: 'pointer',
                  fontFamily: 'monospace'
                }}
              >
                ADD
              </button>
            </div>
            <div style={{ fontSize: '12px' }}>
              {newRestaurant.menuItems?.map((item, index) => (
                <div key={index} style={{ marginBottom: '2px' }}>
                  • {item}
                </div>
              ))}
            </div>
          </div>

          <div style={{ display: 'flex', gap: '10px', justifyContent: 'center' }}>
            <button
              type="submit"
              style={{
                padding: '10px 20px',
                backgroundColor: '#004400',
                color: '#00ff00',
                border: '1px solid #00ff00',
                cursor: 'pointer',
                fontFamily: 'monospace'
              }}
            >
              GENERATE CODE
            </button>
            <button
              type="button"
              onClick={onClose}
              style={{
                padding: '10px 20px',
                backgroundColor: '#440000',
                color: '#ff0000',
                border: '1px solid #ff0000',
                cursor: 'pointer',
                fontFamily: 'monospace'
              }}
            >
              CANCEL
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};
