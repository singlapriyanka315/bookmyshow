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
https://user-images.githubusercontent.com/66158960/210514921-3c60cb5e-3948-4613-9c1d-467e91b41477.mov



https://user-images.githubusercontent.com/66158960/210515029-21c0a24c-95f6-403f-a2eb-e865f1a45a9b.mov


https://user-images.githubusercontent.com/66158960/210515129-6eb3d562-4844-4fd4-b4f4-ed154895313a.mov



https://user-images.githubusercontent.com/66158960/210515049-a7930b52-4956-49cd-9b84-11e8b30da7d6.mov



https://user-images.githubusercontent.com/66158960/210515069-ed8be08d-86b3-4a89-bda5-62749a4b91d2.mov


https://user-images.githubusercontent.com/66158960/210515096-9844dbb7-3f4b-4645-9a8a-f06a0a1392e8.mov



https://user-images.githubusercontent.com/66158960/210515006-15ce530f-cf09-4c35-8b5f-99182f681913.mov



For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


