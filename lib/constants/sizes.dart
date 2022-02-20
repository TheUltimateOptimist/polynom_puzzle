class Sizes{
  static bool onMobile = false;
  static double titleSize(){
    return onMobile ? 35 : 48;
  }

  static double functionTextSize(){
    return onMobile ? 20 : 30;
  }

  static double movesTextSize(){
    return onMobile ? 15 : 20; 
  }

  static double degreeTextSize(){
    return onMobile ? 20 : 25;
  }

  static double explanationTextSize(){
    return onMobile ? 20 : 30;
  }

  static double buttonHeight(){
    return onMobile ? 34 : 60;
  }

  static double buttonTextSize(){
    return onMobile ? 20 : 30;
  }

  static double dialogTitleSize(){
    return onMobile ? 30 : 45;
  }

  static double dialogInfoSize(){
    return onMobile ? 20 : 30;
  }


}