const customerSelect = document.querySelector("#customer-select")
const customerAddressSelect = document.querySelector("#address-select")

document.addEventListener("DOMContentLoaded", function () {
  customerSelect.addEventListener("change", function () {
    const customerId = customerSelect.value

    if (customerId) {
      addressRequest(customerId)
    } else {
      customerAddressSelect.innerHTML = ""
    }
  })
})

function addressRequest(customerId) {
  const url = `/customers/${customerId}/addresses`

  const request = new XMLHttpRequest()

  request.open("GET", url, true)
  request.setRequestHeader(
    "X-CSRF-Token",
    document.querySelector("[name='csrf-token']").content
  )

  request.onload = function () {
    if (request.status >= 200 && request.status < 400) {
      let addresses = JSON.parse(request.responseText)
      customerAddressSelect.innerHTML = ""

      addresses.forEach(function (address) {
        let option = document.createElement("option")
        option.value = address.id
        option.textContent = `${address.name}: ${address.public_place}, ${address.number} - Reference: ${address.reference}`
        customerAddressSelect.appendChild(option)
      })
    }
  }

  request.send()
}
