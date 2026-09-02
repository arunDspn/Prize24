const indiaDateTimeFormatter = new Intl.DateTimeFormat("en-IN", {
    dateStyle: "medium",
    timeStyle: "short",
    timeZone: "Asia/Kolkata",
});

const inrCurrencyFormatter = new Intl.NumberFormat("en-IN", {
    style: "currency",
    currency: "INR",
    maximumFractionDigits: 2,
});

export const formatDate = (value: Date | null) => {
    if (!value) {
        return "Not available";
    }

    return indiaDateTimeFormatter.format(value);
};

export const formatCommission = (value: number | null, currency?: string) => {
    if (value === null) {
        return "Not available";
    }

    if (currency && currency.trim()) {
        return `${currency.toUpperCase()} ${value.toFixed(2)}`;
    }

    return inrCurrencyFormatter.format(value);
};

export const typeToneClasses: Record<string, string> = {
    INITIAL: "bg-amber-50 text-amber-700 ring-amber-200",
    INITIAL_PURCHASE: "bg-amber-50 text-amber-700 ring-amber-200",
    RENEWAL: "bg-emerald-50 text-emerald-700 ring-emerald-200",
    PAYMENT: "bg-blue-50 text-blue-700 ring-blue-200",
    CANCELLATION: "bg-orange-50 text-orange-700 ring-orange-200",
};