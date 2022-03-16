/**
 * @description       : 
 * @author            : Prashant Wayal
 * @group             : 
 * @last modified on  : 03-16-2022
 * @last modified by  : Prashant Wayal
**/
import { LightningElement } from 'lwc';
import Highchart from '@salesforce/resourceUrl/Highcharts';
import { loadScript,loadStyle } from 'lightning/platformResourceLoader';
import getStockData from '@salesforce/apex/StockExchangeDataController.getStockData';

export default class StockData extends LightningElement {
    data;

    value = 'BOM533171'; //default value to set at the time of initial loading
    label = 'United Bank Of India';
    showSpinner = true;

    //Dummy stocks to show to users
    get options() {
        return [
            { label: '20 Microns Ltd.', value: 'BOM533022' },
            { label: '3i Infotech Ltd.', value: 'BOM532628' },
            { label: '3m India Ltd.', value: 'BOM523395' },
            { label: 'Aadhaar Ventures India Ltd.', value: 'BOM531611' },
            { label: 'Abbott India Ltd.', value: 'BOM500488' },
            { label: 'Accelya Kale Solutions Limitd', value: 'BOM532268' },
            { label: 'Acme Resources Ltd', value: 'BOM539391' },
            { label: 'United Bank Of India', value: 'BOM533171' },
            { label: 'Weizmann Forex Ltd.', value: 'BOM533452' },
        ];
    }

    //Handle the stock change event
    handleChange(event) {
        this.showSpinner = true;
        this.value = event.detail.value;
        this.label = event.target.options.find(opt => opt.value === event.detail.value).label;;
        this.loadData();
    }

    //load javscript libs from static resource
    connectedCallback() {
        this.showSpinner = true;
        console.log('inside renderedCallback...');
        loadScript(this, Highchart+'/code/highstock.js')
        .then(() => {
            console.log("SUCCESS: highcharts.js");

            this.loadData();
        })
        .catch(error => console.log(error));
    }

    //get the data from BSE webservice
    loadData() {
        console.log('Loaded...');
        getStockData({bseCode: this.value})
        .then(result => {

            let tempdata = '';
            //Get only some records
            for(var i=result.dataset.data.length-2000; i>=0; i--) {
                let tempArr = ',[';
                for(var j=0; j<result.dataset.data[i].length; j++) {
                    if(j<2){
                        if(j === 0) {
                            tempArr = tempArr+''+Date.parse(new Date(result.dataset.data[i][j]));
                        } else {
                            tempArr = tempArr+', '+result.dataset.data[i][j];
                        }
                        
                    }
                }
                tempArr = tempArr+']';
                tempdata = tempdata+''+tempArr;
            }
            tempdata = tempdata.substring(1);
            this.data = '['+tempdata+']';
            this.generateChart();
        })
        .catch(error => {
            this.error = error;
        });
    }

    //generate the chart for the data received from BSE
    generateChart() {
        const containerId = this.template.querySelector('div').id;
        //console.log('*** containerId => '+containerId);
        //console.log('*** data => '+this.data);
        // Create the chart
        let data1 = JSON.parse(this.data);
        Highcharts.stockChart(this.template.querySelector('div'), {

            chart: {
                width: 1325
            },
            rangeSelector: {
                selected: 1
            },

            title: {
                text: this.label+' EOD Prices'
            },
            
            series: [{
                name: this.value,
                data: data1,
                marker: {
                    enabled: true,
                    radius: 3
                },
                shadow: true,
                tooltip: {
                    valueDecimals: 2
                }
            }]
            
        });
        this.showSpinner = false;
    }
}