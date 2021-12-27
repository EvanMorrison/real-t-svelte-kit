/// <reference types="@sveltejs/kit" />

interface CurrentUser {
	firstName: string;
	lastName: string;
	email: string;
	role: string;
	avatar: string;
}

interface User {
	userId: string;
	firstName: string;
	lastName?: string;
	email: string;
	password?: string;
	avatar?: string;
	role: 'user' | 'admin';
	createdAt: string;
}

interface UserSignup {
	email: string;
	password: string;
	passConfirm: string;
}

interface UserLogin {
	email: string;
	password: string;
}

interface Address {
	street1?: string;
	street2?: string;
	city?: string;
	state?: string;
	zipCode?: string;
}

interface Email {
	emailId?: number;
	category?: string;
	email: string;
	isPrimary?: boolean;
}

interface Org {
	orgId?: number;
	name: string;
	street1?: string;
	street2?: string;
	city?: string;
	state?: string;
	zipCode?: string;
	orgType?: string;
	parent?: Org;
	children?: Org[];
}

interface Person {
	personId?: number;
	userId?: number;
	prefix?: string;
	firstName: string;
	middleName?: string;
	lastName?: string;
	fullName?: string;
	suffix?: string;
	email?: string;
	emails?: {
		category: string;
		address: string;
	}[];
	phone?: number;
	phones?: {
		category: string;
		number: number;
	}[];
	org?: Org;
	orgs?: Org[];
	title?: string;
	notes?: string;
}

interface Party {
	partyId?: number;
	role?: string;
	isOrg?: boolean;
	person?: Person;
	org?: Org;
	partyDisplayIndex?: number;
	projects?: Project[];
}

interface Property {
	propertyId?: number;
	street1?: string;
	street2?: string;
	city?: string;
	state?: string;
	zipCode?: string;
	country?: string;
	county?: string;
	parcelId?: string;
	shortDescription?: string;
	legalDescription?: string;
	projects?: number[];
	vesting?: string;
	assessedValue?: number;
	assessedYear?: number;
	updatedAt?: Date;
}

interface Project {
	projectId?: number;
	projectType?: string;
	createdBy?: User;
	createdAt?: Date;
	updatedBy?: User;
	updatedAt?: Date;
	parcels?: Property[];
	parties?: Party[];
	roles?: string[];
	projectDisplayIndex?: number;
}
