#  Meal Planner


A comprehensive meal planning application built with Flutter that helps users organize their daily meals, discover recipes, and track eating habits.

##  Features

-  User Sign Up & Login using Supabase Auth
-  Email/password authentication
-  Stylish UI with background images
-  Personalized greeting with user metadata (name)
-  Toggle between Login and Sign Up views
-  Secure logout with session clearing


###  Authentication
- User Sign Up & Login using Supabase Auth
- Email/password authentication
- Secure logout with session clearing
- Personalized greeting with user metadata (name)

###  Meal Management
- Browse meals by categories (All, Entree, Main, Dessert)
- Star and save favorite meals
- Schedule meals to specific days/times (Breakfast, Lunch, Dinner)
- View past meal selections
- Export menus as PDF/image

###  UI/UX
- Modern, stylish interface
- Animated transitions
- Responsive design for all devices
- Background images for visual appeal

##  Screens

| Screen | Description | Key Features |
|--------|-------------|--------------|
| Welcome | App introduction | Get started flow |
| Login/Signup | Authentication | Email/password auth, form validation |
| Explore | Discover meals | Category filters, search |
| Favorites | Saved meals | Rating system, quick add |
| Calendar | Meal scheduling | Daily/weekly view, drag-and-drop |
| History | Past meals | Timeline view, statistics |
| Profile | Account management | Edit profile, change password |
| Meal Details | Full meal info | Ingredients, instructions, add to plan |

##  Technical Stack

**Built With:**
- Flutter 3.x
- Supabase (Auth + Database)
- Dart 3.x

**Key Packages:**
- `supabase_flutter`: Supabase integration
- `provider`: State management
- `intl`: Date formatting
- `pdf`: PDF generation
- `cached_network_image`: Image loading
- `flutter_riverpod`: State management (optional)

##  Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Supabase account

### Installation

1. Clone the repository:
```bash
git clone https://github.com/nimo24/meal_planner.git
cd meal_planner
