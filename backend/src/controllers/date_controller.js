class CustomDates {
    constructor() {
        if (!CustomDates.instance) {
            this.date = new Date();
            CustomDates.instance = this;
        }
        return CustomDates.instance;
    }

    getSimpleDate() {
        return this.date;
    }

    getJsonFormattedDate() {
        const day = this.date.getDate();
        const month = this.date.getMonth() + 1; // Adding 1 because getMonth() returns zero-based month
        const year = this.date.getFullYear();
        const hour = this.date.getHours();
        const minutes = this.date.getMinutes();
        const second = this.date.getSeconds();

        return { day, month, year, hour, minutes, second };
    }

    getStringFormattedDate() {
        const day = this.date.getDate();
        const month = this.date.getMonth() + 1;
        const year = this.date.getFullYear();
        const hour = this.date.getHours();
        const minutes = this.date.getMinutes();
        const second = this.date.getSeconds();

        return `${day}/${month}/${year}/${hour}/${minutes}/${second}`;
    }

    // getProductExpireDate() {
    //     const day = this.date.getDate();
    //     const month = this.date.getMonth() + 1;
    //     const year = this.date.getFullYear();
    //     const hour = this.date.getHours();
    //     const minutes = this.date.getMinutes();
    //     const second = this.date.getSeconds();

    //     return `${day}/${month}/${year}/${hour}/${minutes}/${second}`;
    // }
}

const customDate = new CustomDates();

module.exports = customDate;