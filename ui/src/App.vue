<template>
  <div id="app">
    <div class="container" style="padding:20px;">
      <form>
        <div class="row">
          <div class="col-12">
            <input class="form-control" type="text" v-model="address" placeholder="address" />
          </div>
        </div>
        <div class="row pt-4">
            <div class="col-6">
              <input class="form-control" type="text" v-model="birthdate" placeholder="birthdate" />
            </div>
            <div class="col-6">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" v-model="birthdate_perm" value="1">
                <label class="form-check-label" for="defaultCheck1">
                  show birthdate
                </label>
              </div>
            </div>
        </div>

        <div class="row pt-4">
          <div class="col-6">
            <input class="form-control" type="text" v-model="nationality" placeholder="nationality" />
          </div>
          <div class="col-6">
            <div class="form-check">
              <input class="form-check-input" type="checkbox" v-model="nationality_perm" value="1">
              <label class="form-check-label" for="defaultCheck1">
                show nationality
              </label>
            </div>
          </div>
        </div>

        <div class="row pt-4">
          <div class="col-6">
            <input class="form-control" type="text" v-model="city" placeholder="city" />
          </div>
          <div class="col-6">
            <div class="form-check">
              <input class="form-check-input" type="checkbox" v-model="city_perm" value="1">
              <label class="form-check-label" for="defaultCheck1">
                show city
              </label>
            </div>
          </div>
        </div>

        <div class="row pt-4">
          <div class="col-6">
            <input class="form-control" type="text" v-model="gender" placeholder="gender" />
          </div>
          <div class="col-6">
            <div class="form-check">
              <input class="form-check-input" type="checkbox" v-model="gender_perm" value="1">
              <label class="form-check-label" for="defaultCheck1">
                show gender
              </label>
            </div>
          </div>
        </div>

        <div class="row pt-4">
          <div class="col-6">
            <input class="form-control" type="text" v-model="imei" placeholder="imei" />
          </div>
          <div class="col-6">
            <div class="form-check">
              <input class="form-check-input" type="checkbox" v-model="imei_perm" value="1">
              <label class="form-check-label" for="defaultCheck1">
                show imei
              </label>
            </div>
          </div>
        </div>
        <div class="row pt-4">
          <div class="col-12">
            <button type="button" @click="saveData" class="bnt btn-sm"> Save </button>
          </div>
        </div>
      </form>
      <div class="row">
        <div class="col-12">
          <span>{{ result }}</span>
        </div>
      </div>
      <form class="mt-3">
      <div class="row">
        <div class="col-6">
          <input class="form-control" type="text" v-model="from_address" placeholder="From Address" />
        </div>
        <div class="col-6">
          <input class="form-control" type="text" v-model="to_address" placeholder="to_address" />
        </div>
      </div>
      <div class="row mt-2">
          <div class="col-12">
            <button type="button" @click="getData" class="bnt btn-sm"> Get data </button>
          </div>
      </div>
      </form>
      <div class="row pt-4">
        <div class="col-12">
          <table class="table">
            <tr>
              <th>Clear Text</th>
              <th>Hash Text</th>
            </tr>
            <tr v-for="(d, index) in result_get.data" :key="index">
              <th>
                <span v-if="(from_address !== to_address && result_get.permission[index])">
                  {{d}} {{ result_get.permission[index] }}
                </span>
                <span v-else-if="from_address === to_address">
                  {{d}} + {{ result_get.permission[index] }}
                </span>
              </th>
              <th>{{ result_get.encrypt[index] }}</th>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// import Content from './components/Content';
// import getWeb3 from "./utils/getWeb3";
import Biodata from "./utils/contracts/Biodata";
import Web3 from 'web3'

export default {
  name: 'app',
  data() {
    return {
      web: null,
      contractAddress: '0x9775E93bB2D4776696A13426289894c9f42EF7D6', // 0.00687926 ETH
      contract: null,
      address: '',
      birthdate: '',
      birthdate_perm: false,
      nationality: '',
      nationality_perm: false,
      imei: '',
      imei_perm: false,
      city: '',
      city_perm: false,
      gender: '',
      gender_perm: false,
      from_address: '',
      to_address: '',
      result: {},
      result_get: [],
    }
  },
  async mounted() {

    const provider = await new Web3.providers.HttpProvider(
        // "http://127.0.0.1:9545"
        "http://127.0.0.1:7545"
      );
    this.web = await new Web3(provider);
    // const networkId = await this.web.eth.net.getId();
    const deployedNetwork = await Biodata.networks[5777];

    let contract = await new this.web.eth.Contract(
            Biodata.abi,
            deployedNetwork && deployedNetwork.address,
        );
    this.contract = contract;
  },
  methods: {
    saveData: function(){
      const birthdate = this.web.utils.toHex(this.birthdate)
      const nationality = this.web.utils.toHex(this.nationality)
      const imei = this.web.utils.toHex(this.imei)
      const gender = this.web.utils.toHex(this.gender)
      const city = this.web.utils.toHex(this.city)

      const birthdate_perm = this.birthdate_perm
      const nationality_perm = this.nationality_perm
      const imei_perm = this.imei_perm
      const city_perm = this.city_perm
      const gender_perm = this.gender_perm

      this.contract.methods.setAttribute(
        nationality, nationality_perm,
        birthdate, birthdate_perm,
        city, city_perm,
        imei, imei_perm,
        gender, gender_perm
      ).send({from: this.address, gas:3000000}).then(res => {
          this.result = res
      })
      .catch(err => console.log(err));

    },
    getData: function(){
      if(!this.to_address && !this.from_address)
        return

      let that = this
      this.contract.methods.getAttribute(this.to_address).call({from: this.from_address}, function(err, ress) {
          let data = [];
          let permission = [];
          let encrypt = [];
          // console.log(ress)
          // console.log(err)
          for(let i=0; i < ress[0].length; i++)
          {
            encrypt.push(ress[0][i])
            console.log(that.web.utils.hexToString(ress[0][i]))
            data.push((that.web.utils.hexToString(ress[0][i])))

            permission.push(ress[1][i])
          }

          that.result_get = {"data": data, "encrypt": encrypt, "permission": permission}
      })
    }
  },
}

</script>
