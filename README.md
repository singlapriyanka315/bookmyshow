# BookMyShow Clone

A new Flutter project.

## Getting Started

Some of basic features of app are:
- Whole app is made with Flutter .
- Multiple users can create account and can login via credentials (Email and Password) used to create account with. For this I've used Firebase-auth.
- User will stay signed in until they click sign out.
- At the time of creating account, personal data entered by user is getting stored in Firestore Database . For this I've user Firebase-Firestore.
- User can update their personal data (except email used in authentication) and the same will be updated in firestore database.and reflect on other screens.
- Location permission is mandatory without which user won't be able to move forward. So app will check if permission is given or not and if not then will ask user to give permission to access location. If permission denied by user then alert will pop up. For this I've used geolocator and permission_handler.
- User can search for any movie by typing that in search box.
- All the data shown is getting from API (free api provided by movieglu).
- User can select date, near by cinema and specific time slot of movie selected to book ticket for.
- At the time of seats selection available and already sold seats are shown with colour difference and user can only select available seats. For this I've used Firebase-Firestore where already sold seats are stored.
- Before selecting cinema there is info button given for user to get basic details about that cinema like location, address and can open maps to get an idea how far is that cinema from their current location.
- After payment tickets will be booked and user can see that in active tickets and after ticket gets expired that will be deleted from active tickets automatically.
- User can see all the bookings done from that account in orders.
- Every data is being stored in Firebase- Firestore.
- BLOC is used to separate most of the UI and Logic part and to manage state.
- Splash screen is also added and for icons Flutter-icons are used.
- Without internet connectivity user can't move forward from splash screen.
- App is responding for every action done by user.
- Lastly, errors are handled in case of no internet connection or any other error.



https://user-images.githubusercontent.com/66158960/214066589-25d78583-3562-4ccf-9afd-fe26e62d53b0.mov




https://user-images.githubusercontent.com/66158960/214065572-5341dcd1-c5e1-4cbc-a5a2-9d693ac8fb50.mov




https://user-images.githubusercontent.com/66158960/214066050-b2375155-9618-4385-ad46-bde1e220dc64.mov



https://user-images.githubusercontent.com/66158960/214065862-334b2b2b-96c3-4ed0-8a30-2961c8083cfd.mov



https://user-images.githubusercontent.com/66158960/214066227-8a656620-40ce-4d56-ba09-2b7fac677b85.mov




For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


