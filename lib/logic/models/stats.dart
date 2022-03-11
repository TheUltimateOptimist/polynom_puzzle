class Stats {
  int overallGamesPlayed;
  int overallGamesWon;
  int overallGamesLost;
  int linearGamesPlayed;
  int linearGamesWon;
  int linearGamesLost;
  int quadraticGamesPlayed;
  int quadraticGamesWon;
  int quadraticGamesLost;
  int cubicGamesPlayed;
  int cubicGamesWon;
  int cubicGamesLost;
  Stats({
    this.overallGamesPlayed = 0,
    this.overallGamesWon = 0,
    this.overallGamesLost = 0,
    this.linearGamesPlayed = 0,
    this.linearGamesWon = 0,
    this.linearGamesLost = 0,
    this.quadraticGamesPlayed = 0,
    this.quadraticGamesWon = 0,
    this.quadraticGamesLost = 0,
    this.cubicGamesPlayed = 0,
    this.cubicGamesWon = 0,
    this.cubicGamesLost = 0,
  });

  Map<String, int> toMap() {
    return {
      "gamesPlayed": overallGamesPlayed,
      "gamesWon": overallGamesWon,
      "gamesLost": overallGamesLost,
      "linearGamesPlayed": linearGamesPlayed,
      "linearGamesWon": linearGamesWon,
      "linearGamesLost": linearGamesLost,
      "quadraticGamesPlayed": quadraticGamesPlayed,
      "quadraticGamesWon": quadraticGamesWon,
      "quadraticGamesLost": quadraticGamesLost,
      "cubicGamesPlayed": cubicGamesPlayed,
      "cubicGamesWon": cubicGamesWon,
      "cubicGamesLost": cubicGamesLost,
    };
  }

  static Stats fromMap(var map) {
    return Stats(
      overallGamesPlayed: map["gamesPlayed"]!,
      overallGamesWon: map["gamesWon"]!,
      overallGamesLost: map["gamesLost"]!,
      linearGamesPlayed: map["linearGamesPlayed"]!,
      linearGamesWon: map["linearGamesWon"]!,
      linearGamesLost: map["linearGamesLost"]!,
      quadraticGamesPlayed: map["quadraticGamesPlayed"]!,
      quadraticGamesWon: map["quadraticGamesWon"]!,
      quadraticGamesLost: map["quadraticGamesLost"]!,
      cubicGamesPlayed: map["cubicGamesPlayed"]!,
      cubicGamesWon: map["cubicGamesWon"]!,
      cubicGamesLost: map["cubicGamesLost"]!,
    );
  }
}
