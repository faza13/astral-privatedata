pragma solidity ^0.5.0;
// import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts/ownership/Ownable.sol";
/**
 * The biodata contract does this and that...
   transaction cost   740453 gas
 execution cost   516189 gas
 */
contract Biodata {
// internal extrnal cobain
  struct Attribute {
    bytes32[] data;
    bool[] permission;
  }

  mapping(address => Attribute) private attributes;

  Attribute[] private attribute;

  //public
  // transaction cost  42815 gas
  // execution cost   20135 gas
  // external
  // transaction cost  24143 gas
  // execution cost   1463 gas
  function getAttribute(address _addr) public returns (bytes32[] memory, bool[] memory){
      Attribute storage sender =  attributes[_addr];
      // birthdate = 0;

      // if(sender.birthdate[0] > 0 || msg.sender == _addr)
      //   birthdate = sender.birthdate[1];

      // nationality = 0;
      // if(sender.nationality[0] > 0 || msg.sender == _addr)
      //   nationality = sender.nationality[1];

      // gender = 0;
      // if(sender.gender[0] > 0 || msg.sender == _addr)
      //   gender = sender.gender[1];

      // city = 0;
      // if(sender.city[0] > 0 || msg.sender == _addr)
      //   city = sender.city[1];

      // imei = 0;
      // if(sender.imei[0] > 0 || msg.sender == _addr)
      //   imei = sender.imei[1];
      // uint arr_length = sender.permission.length;
      // bytes32[] memory result = new bytes32[](arr_length);
      // for(uint i = 0; i < arr_length; i++) {
      //   if(sender.permission[i] > 1){
      //     result[i] = sender.data[i];
      //   }
      //   else{
      //     result[i] = "";
      //   }
      // }
      uint length = sender.data.length;
      bytes32[] memory data = new bytes32[](length);
      bool[] memory permission = new bool[](length);

      for (uint i = 0; i < length; i++) {
            data[i] = sender.data[i];
            permission[i] = sender.permission[i];
        }

      return (data, permission);
  }
  // public
  // transaction cost  245142 gas
  // execution cost   219518 gas
  // external
  // transaction cost  245142 gas
  // execution cost   219518 gas
  function setAttribute (
    bytes32 nationality, bool nationality_perm,
    bytes32 birthdate, bool birthdate_perm,
    bytes32 city, bool city_perm,
    bytes32 imei, bool imei_perm,
    bytes32 gender, bool gender_perm
    ) public
  {
    Attribute storage sender = attributes[msg.sender];
    sender.permission = [nationality_perm ,birthdate_perm ,city_perm ,gender_perm ,imei_perm];
    sender.data = [nationality, birthdate, city, gender, imei];
    // sender.nationality = [nationality_perm, nationality];
    // sender.birthdate = [birthdate_perm, birthdate];
    // sender.city = [city_perm, city];
    // sender.gender = [gender_perm, gender];
    // sender.imei = [imei_perm, imei];
  }

}
