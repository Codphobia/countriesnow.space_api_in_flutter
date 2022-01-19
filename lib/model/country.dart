

class Country
{
  String name;
  String flag;

  Country({required this.name,required this.flag});


  static Country fromMap(Map<String , dynamic> map)
  {
    return Country(name: map['name'], flag: map['flag']);
  }
}