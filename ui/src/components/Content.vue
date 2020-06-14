<template>
  <div class="container">
    <form class="form-inline">
      <div class="row">
          <div class="col-6">
          <input class="form-control form-control-lg" type="text" v-model='birthdate' placeholder="birthdate" />
          </div>
          <div class="col-6">
          <input class="form-control form-control-lg" type="checkbox" v-model='birthdate_perm' value="1" />
          <label>show biodata</label>
          </div>
      </div>

      <div class="row">
          <div class="col-6">
          <input class="form-control form-control-lg" type="text" v-model='nationality' placeholder="nationality" />
          </div>
          <div class="col-6">
          <input class="form-control form-control-lg" type="checkbox" v-model='nationality_perm' />
          <label>show nationality</label>
          </div>
      </div>
      <div class="row">
          <div class="col-12">
          <button type="button" class="btn-lg btn-primary">Save</button>
          </div>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  data: function() {
    return {
      fiatPrice: null,
      reserveStartDate: null,
      reserveEndDate: null,
      numberOfTravelers: null,
      customerAddress: null,
      daysBeforeStartForRefund: [],
      refundPercentages: [],
    }
  }
}
</script>
<!--uint fiatPrice, uint reserveStartDate, uint reserveEndDate, uint numberOfTravelers, address customerAddress, uint[] calldata daysBeforeStartForRefund, uint[] calldata refundPercentages-->
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
