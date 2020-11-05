<template>
  <b-container id="app" class="mx-auto mt-4" style="max-width:400px;">
    <h1>Admin panel</h1>
    <b-form class="mt-4" @submit.prevent="onSubmit">
      <b-form-group>
        <label for="value">USD quote</label>
        <b-form-input
          id="value"
          name="value"
          v-model="form.value"
          required
          pattern="\d+(\.\d+)?"
          placeholder="Enter value, e.g. 80.25"
        ></b-form-input>
        <small class="form-text text-muted">Format: 80.42</small>
      </b-form-group>
      <label for="expirationDate">Expiration date</label>
      <b-form-input
        id="expirationDate"
        name="expirationDate"
        v-model="form.expirationDate"
        type="datetime-local"
        required
      ></b-form-input>
      <small class="form-text text-muted"></small>
      <b-button class="mt-3" type="submit" variant="primary">Submit</b-button>
      <b-alert class="mt-3" variant="success" fade :show="alertShow" dismissible>
        Quote value successfully changed
      </b-alert>
    </b-form>
  </b-container>
</template>

<script>
export default {
  props: ['value', 'expirationDate'],
  data() {
    return {
      form: {
        value: this.value,
        expirationDate: this.datetimeLocalFormat()
      },
      alertShow: false
    }
  },
  methods: {
    onSubmit(evt) {
      this.bringAlert()

      const data = new FormData()
      data.append('value', this.form.value)
      data.append('expirationDate', Date.parse(this.form.expirationDate) / 1000)

      fetch('/admin', {
        method: 'POST',
        body: data
      })
    },

    bringAlert() {
      if (this.alertShow) {
        this.alertShow = false
      }
      this.$nextTick(() => {
        this.alertShow = true
      })
    },

    datetimeLocalFormat() {
      if (this.expirationDate) {
        let date = new Date(this.expirationDate * 1000)
        date.setMinutes(date.getMinutes() - date.getTimezoneOffset())
        return date.toISOString().slice(0,16)
      }
    }
  }
}
</script>
