import { LightningElement, wire, track } from 'lwc';
import getWeatherInformationBasedOnCity from '@salesforce/apex/weatherIntegrationClass.getWeatherInformationBasedOnCity';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class WeatherDataComponent extends LightningElement {

    @track cityInputNameValue = '';
    @track weatherDetails = '';
    @track weatherDescription = '';
    inputHandleChange(event) {
        this.cityInputNameValue = event.target.value;
    }
    handleFocus(event) {
        const inputElement = this.template.querySelector('input');
        inputElement.style.backgroundColor = 'lightblue';
    }
    handleBlur(event) {
        const inputElement = this.template.querySelector('input');
        inputElement.style.backgroundColor = '';
    }
    handleClick() {
        getWeatherInformationBasedOnCity({ cityName: this.cityInputNameValue })
            .then(result => {
                if (result != null) {
                    this.weatherDetails = result;
                    this.weatherDescription = result[0].cityWeatherDescription;
                    console.log('this.weatherDetails', this.weatherDetails);
                    console.log('this.weatherDescription', this.weatherDescription);
                    this.imagefunction();
                }
                else if (result == null) {
                    //alert('Please Check The City Name');
                    const evt = new ShowToastEvent({
                        title: 'Not Found',
                        message: 'Please Check The City Name',
                        variant: 'info',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(evt);
                }

            }).catch(error => {
                console.log('error', error);
            })
    }

    @track imageurl = '';

    imagefunction() {
        if (this.weatherDescription.includes('few clouds')) {
            this.imageurl = 'https://cdn.https://media.istockphoto.com/id/873663800/photo/beautiful-blue-sky-with-clouds-background-sky-clouds-sky-with-clouds-weather-nature-cloud-blue.jpg?s=612x612&w=0&k=20&c=tbGeKWNV3nT-JLJg5miflyprLxq3VpX7gvA6G69c2xk=.com/images/Weather/OP/04d.png';
        } else if (this.weatherDescription.includes('clear sky')) {
            this.imageurl = 'https://c1.wallpaperflare.com/preview/24/65/246/sky-cloud-solo-only.jpg';
        } else if (this.weatherDescription.includes('scattered clouds')) {
            this.imageurl = 'https://media.istockphoto.com/id/480531006/photo/cirrocumulus-cloud.jpg?s=1024x1024&w=is&k=20&c=V0NwITXsxwZ8UJfxIbGbw33NfRkkVGBMd20tu97JMC4=';
        } else if (this.weatherDescription.includes('broken clouds')) {
            this.imageurl = 'https://c0.wallpaperflare.com/preview/532/447/657/scattered-white-clouds.jpg';
        }
        else if (this.weatherDescription.includes('shower rain')) {
            this.imageurl = 'https://cdn.pixabay.com/photo/2022/04/27/01/12/weather-7159428_1280.png';
        } else if (this.weatherDescription.includes('rain')) {
            this.imageurl = 'https://img.freepik.com/premium-psd/rainy-day-weather-forecast-icon-meteorological-sign-3d-render_471402-557.jpg?w=740';
        } else if (this.weatherDescription.includes('thunderstorm')) {
            this.imageurl = 'https://previews.123rf.com/images/maheyfoto/maheyfoto1705/maheyfoto170500073/78840264-coming-thunderstorm-with-first-raindrops-weather-icon-weather-forecast-weather-report-dark-gray.jpg';
        } else if (this.weatherDescription.includes('snow')) {
            this.imageurl = 'https://c8.alamy.com/comp/2DCNBB8/snow-cloud-for-snowy-and-overcast-weather-symbol-line-art-vector-icon-2DCNBB8.jpg';
        } else if (this.weatherDescription.includes('mist')) {
            this.imageurl = 'https://c8.alamy.com/comp/2K2K88W/cloud-and-fog-symbols-isolated-on-white-background-3d-illustration-2K2K88W.jpg';
        }

    }
}