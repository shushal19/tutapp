
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


void main()
{
  runApp(const MaterialApp(home:OnboardingPage(),));
}
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  final PageController _pageController=PageController();
   int _currentpage=0;

    final List<Widget> _onboardingScreens = [
    const OnboardingScreen(
      title: 'page 1',
      description: 'onboarding screen 1',
      imagePath:'assets/images/logo.svg',
    ),
    const OnboardingScreen(
      title: 'page 2',
      description: 'onboarding screen 2',
      imagePath: 'assets/images/logo.svg',
    ),
    const OnboardingScreen(
      title: 'page 3',
      description: 'onboarding screen 3',
      imagePath: 'assets/images/logo.svg',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(Icons.menu),
        ],
      ),
      
      
      body:
      PageView.builder(
        
        controller: _pageController,
      itemCount: _onboardingScreens.length,
        itemBuilder:(BuildContext context, int index) {
          return _onboardingScreens[index];
        },
        onPageChanged: (int page) {
          setState(() {
            _currentpage=page;
          });},
           ),

           
           
           bottomSheet: Container(height: 100,width: double.infinity,color: Colors.red,
           child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: const Text("skip",style: TextStyle(color:Colors.black),))
              ],
            ),

            
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                
                ElevatedButton(onPressed: () {
                  _pageController.animateToPage(getPreviousIndex(_currentpage), duration: const Duration(milliseconds: 500), curve: Curves.linear);
                }, child: const Icon(Icons.arrow_back_ios)),

                Row(

                  children: [
                    for(int i=0;i<_onboardingScreens.length;i++)
                      getProperBotton(i,_currentpage)
                    
                  ],
                ),
 
                
                ElevatedButton(onPressed: () {
                  _pageController.animateToPage(getNextIndex(_currentpage), duration: const Duration(milliseconds: 500), curve: Curves.linear);
                }, child: const Icon(Icons.arrow_forward_ios)),
                
               
                
                
                
              ]
            )
           ],

           )
           ,),

             
           );

        
    
  }

  int getNextIndex(currentpage){
    int newpage=++currentpage;
    if(newpage==_onboardingScreens.length){
      return 0;
    }
    else{
      return newpage;
    }
    

  }

  getPreviousIndex(currentpage){
    int nextpage=--currentpage;
    if(nextpage<0){
      return _onboardingScreens.length;
    }
    else
    {
      return nextpage;
    }
  }
  Widget getProperBotton(int i, int currentpage) {
    if (i==_currentpage) {
      return Padding(padding: const EdgeInsets.all(8),child: SvgPicture.asset("assets/images/circleHollowBottomAppbarBoarding.svg",height:20 ,),);
      
    }
    else{
     return Padding(padding: const EdgeInsets.all(8),child:SvgPicture.asset("assets/images/circleSolidBottomAppbarBoarding.svg",height: 20,),);
    }

}
}






class OnboardingScreen extends StatelessWidget {
   final String title;
  final String description;
  final String imagePath;

    const OnboardingScreen({super.key, required this.title, required this.description, required this.imagePath});



   

  @override
  Widget build(BuildContext context) {
    return  Column(
      
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title),

        const SizedBox(height: 20,),

        Text(description),
        const SizedBox(height: 20,),
        SvgPicture.asset(imagePath),
        



      
      ],

    );
  }
}